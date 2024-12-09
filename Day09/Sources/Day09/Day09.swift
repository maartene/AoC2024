// The Swift Programming Language
// https://docs.swift.org/swift-book

// MARK: Star 1
func defragmentFilesystemAndReturnChecksum(filesystemString: String) -> Int {
    let defragmentedFilesystem = defragmentFilesystem(filesystemString)
    return calculateChecksum(expandedFilesystem: defragmentedFilesystem)
}

func defragmentFilesystem(_ filesystem: String) -> [Int?] {
    let expandedFilesystem = expandFilesystem(filesystem)
    
    var defragmentedFilesystem = expandedFilesystem
    
    guard var nextNil: Int = defragmentedFilesystem.firstIndex(of: nil), var lastFileID = defragmentedFilesystem.lastIndex(where: { $0 != nil } ) else {
        return expandedFilesystem
    }
    
    while nextNil < lastFileID {
        defragmentedFilesystem.swapAt(nextNil, lastFileID)
        
        nextNil += 1
        while defragmentedFilesystem[nextNil] != nil {
            nextNil += 1
        }
        
        lastFileID -= 1
        while defragmentedFilesystem[lastFileID] == nil {
            lastFileID -= 1
        }
    }
    
    return defragmentedFilesystem.filter { $0 != nil }
}

// MARK: Star 2
func defragmentFilesystemBasedOnFilesAndReturnChecksum(_ filesystem: String) -> Int {
    let defragmentedFilesystem = defragmentFilesystemBasedOnFiles(filesystem)
    return calculateChecksum(expandedFilesystem: defragmentedFilesystem)
}

func defragmentFilesystemBasedOnFiles(_ filesystem: String) -> [Int?] {
    let convertedFilesystem = convertFilesystemStringIntoFilesAndFreespace(filesystem)
    
    let filesToMove: [File] = convertedFilesystem.filter { $0.id != nil }.reversed()
    
    var defragmentedFilesystem = convertFilesAndFreespaceIntoExpandedFilesystem(convertedFilesystem)
    for fileToMove in filesToMove {
        printExpandedFilesystem(defragmentedFilesystem)
        let defragmentedFilesAndFreespace = convertExpandedFilesystemIntoFilesAndFreespace(defragmentedFilesystem)
        // find free space
        if let freespace = defragmentedFilesAndFreespace.first(where: { $0.id == nil && $0.size >= fileToMove.size }), freespace.startPosition < fileToMove.startPosition {
            for i in 0 ..< fileToMove.size {
                defragmentedFilesystem[freespace.startPosition + i] = fileToMove.id
                defragmentedFilesystem[fileToMove.startPosition + i] = nil
            }
        }
    }
    

    return defragmentedFilesystem
}

struct File: Equatable {
    let id: Int?
    let size: Int
    let startPosition: Int
    
    init(id: Int? = nil, size: Int, startPosition: Int) {
        self.id = id
        self.size = size
        self.startPosition = startPosition
    }
}

func printExpandedFilesystem(_ filesystem: [Int?]) {
    var result = ""
    for i in 0 ..< filesystem.count {
        if let fileId = filesystem[i] {
            result += "\(fileId)"
        } else {
            result += "."
        }
    }
    print(result)
}

func convertFilesystemStringIntoFilesAndFreespace(_ filesystemString: String) -> [File] {
    let filesystem = filesystemString.map { String($0)
    }
        .compactMap(Int.init)
    
    var result = [File]()
    var isFile = true
    
    var fileCount = 0
    var position = 0
    for size in filesystem {
        if isFile {
            result.append(File(id: fileCount, size: size, startPosition: position))
            isFile = false
            fileCount += 1
        } else {
            isFile = true
            result.append(File(size: size, startPosition: position))
        }
        position += size
    }
    
    return result.filter { $0.id == 0 || $0.size > 0 }
}

func convertFilesAndFreespaceIntoExpandedFilesystem(_ filesAndFreespace: [File]) -> [Int?] {
    var result = [Int?]()
    for file in filesAndFreespace {
        let contents = Array(repeating: file.id, count: file.size)
        result.append(contentsOf: contents)
    }
    return result
}

func convertExpandedFilesystemIntoFilesAndFreespace(_ expandedFilesystem: [Int?]) -> [File] {
    var result = [File]()
    var size = 1
    for position in 1 ..< expandedFilesystem.count {
        if expandedFilesystem[position] != expandedFilesystem[position - 1] {
            result.append(File(id: expandedFilesystem[position - 1], size: size, startPosition: position - size))
            size = 1
        } else {
            size += 1
        }
    }
    
    result.append(File(id: expandedFilesystem.last!, size: size, startPosition: expandedFilesystem.count - size))
    
    return result
}


// MARK: Util

func calculateChecksum(expandedFilesystem: [Int?]) -> Int {
    var checksum = 0
    
    for i in 0 ..< expandedFilesystem.count {
        if let expandedFile = expandedFilesystem[i] {
            checksum += i * expandedFile
        }
    }
    
    return checksum
}

func expandFilesystem(_ filesystemString: String) -> [Int?] {
    let filesystem = filesystemString.map { String($0)
    }
        .compactMap(Int.init)
    
    var result = [Int?]()
    var isFile = true
    
    var fileCount = 0
    for number in filesystem {
        if isFile {
            let blocksToInsert = Array(repeating: fileCount, count: number)
            result.append(contentsOf: blocksToInsert)
            isFile = false
            fileCount += 1
        } else {
            isFile = true
            let blocksToInsert: [Int?] = Array(repeating: nil, count: number)
            result.append(contentsOf: blocksToInsert)
        }
    }
    
    return result
}

func convertExpandedFilesystemString(_ expandedFilesystemString: String) -> [Int?] {
    expandedFilesystemString
        .map { String($0) }
        .map { Int($0) }
}

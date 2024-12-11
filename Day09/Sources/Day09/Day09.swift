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
    var expandedFilesystem = expandFilesystem(filesystem)
    
    var fileID = expandedFilesystem.compactMap { $0 }.max()!

    while fileID >= 0 {
        print("Moving file: \(fileID)")
        if let startOfFileToMove: Int = expandedFilesystem.firstIndex(of: fileID), 
            let endOfFileToMove: Int = expandedFilesystem.lastIndex(of: fileID) {
            let fileSize = endOfFileToMove - startOfFileToMove + 1
            // find some place
            if let startOfFreespaceRegion = findFirstFreeRegion(in: expandedFilesystem, ofSize: fileSize), startOfFreespaceRegion < startOfFileToMove {
                for i in 0 ..< fileSize {
                    expandedFilesystem.swapAt(startOfFileToMove + i, startOfFreespaceRegion + i)
                }
            }
        } 
        fileID -= 1
    }

    return expandedFilesystem
}

func findFirstFreeRegion(in filesystem: [Int?], ofSize filesize: Int) -> Int? {
    var filePointer = 0
    while filePointer < filesystem.count {
        if filesystem[filePointer] == nil {
            let startOfRegion = filePointer
            var freeCount = 0
            while filePointer < filesystem.count && filesystem[filePointer] == nil {
                freeCount += 1
                filePointer += 1
            }

            if freeCount >= filesize {
                return startOfRegion
            }
        }
        filePointer += 1
    }
    
    return nil
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
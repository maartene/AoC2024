// The Swift Programming Language
// https://docs.swift.org/swift-book

func defragmentFilesystemAndReturnChecksum(filesystemString: String) -> Int {
    let defragmentedFilesystem = defragmentFilesystem(filesystemString)
    return calculateChecksum(expandedFilesystem: defragmentedFilesystem)
}

func defragmentFilesystem(_ filesystem: String) -> [Int?] {
    let expandedFilesystem = expandFilesystem(filesystem)
    
    var defragmentedFilesystem = expandedFilesystem
    
    var nextNil: Int = defragmentedFilesystem.firstIndex(of: nil)!
    var lastFileID = defragmentedFilesystem.lastIndex(where: { $0 != nil } )!
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
    
    return defragmentedFilesystem
}

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

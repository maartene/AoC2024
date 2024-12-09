// The Swift Programming Language
// https://docs.swift.org/swift-book

func defragmentFilesystem(_ filesystem: String) -> String {
    filesystem
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

import Testing
@testable import Day09

let exampleInput = "2333133121414131402"

@Suite("To get the first star on day 09") struct Day09StarOneTests {
    @Test("Calculate checksum for defragmented filesystem") func calculateChecksumForDefragmentedFilesystem() {
        let expandedFilesystem = convertExpandedFilesystemString("0099811188827773336446555566..............")
        
        #expect(calculateChecksum(expandedFilesystem: expandedFilesystem) == 1928)
    }
    
    @Test("Expand a filesystem", arguments: [
        ("12345", "0..111....22222"),
        ("2333133121414131402", "00...111...2...333.44.5555.6666.777.888899")
    ]) func testExpandFilesystem(testcase: (filesystemString: String, expectedFilesystemString: String)) {
        let expected = convertExpandedFilesystemString(testcase.expectedFilesystemString)
        
        #expect(expandFilesystem(testcase.filesystemString) == expected)
    }
    
    @Test("Defragment a filesystem that is already defragmented remains unchanged", arguments: [
        ("10", [0]),
        ("20", [0,0])
    ]) func defragmentDefragmentedFilesystem(testcase: (filesystem: String, expected: [Int?])) {
        #expect(defragmentFilesystem(testcase.filesystem) == testcase.expected)
    }
    
    @Test("Defragment a filesystem", arguments: [
        ("111","01"),
        ("12345", "022111222"),
        ("2333133121414131402", "0099811188827773336446555566")
    ]) func defragmentingAFilesystemCreatesExpectedResult(testcase: (filesystem: String, expected: String)) {
        let expected = convertExpandedFilesystemString(testcase.expected)
        #expect(defragmentFilesystem(testcase.filesystem) == expected)
    }
    
    @Test("The checksum for the defragmented filesystem for the example input should be 1928") func checksumForDefragmentedFilesystem_forExampleInput() {
        #expect(defragmentFilesystemAndReturnChecksum(filesystemString: exampleInput) == 1928)
    }
    
    @Test("The checksum for the defragmented filesystem for the actual input should be 6398252054886") func checksumForDefragmentedFilesystem_forActualInput() {
        #expect(defragmentFilesystemAndReturnChecksum(filesystemString: input) == 6398252054886)
    }
}

@Suite("To get the second star on day 09") struct Day09StarTwoTests {
//    @Test("The example input defragments down to '00992111777.44.333....5555.6666.....8888..'") func defragmentExampleInput() {
//        let expected = convertExpandedFilesystemString("00992111777.44.333....5555.6666.....8888")
//        #expect(defragmentFilesystemBasedOnFiles(exampleInput) == expected)
//    }
}

import Testing
@testable import Day09

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

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

}

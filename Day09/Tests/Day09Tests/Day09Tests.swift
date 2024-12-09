import Testing
@testable import Day09

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 09") struct Day09StarOneTests {
    @Test("Defragment a filesystem that is already defragmented remains unchanged") func defragmentDefragmentedFilesystem() {
        let filesystem = "90909"
        #expect(defragmentFilesystem(filesystem) == "90909")
    }
    
    @Test("Calculate checksum for defragmented filesystem") func calculateChecksumForDefragmentedFilesystem() {
        let expandedFilesystem = "0099811188827773336446555566.............."
            .map { String($0) }
            .map { Int($0) }
        
        #expect(calculateChecksum(expandedFilesystem: expandedFilesystem) == 1928)
    }
    
    @Test("Expand a filesystem", arguments: [
        ("12345", "0..111....22222"),
        ("2333133121414131402", "00...111...2...333.44.5555.6666.777.888899")
    ]) func testExpandFilesystem(testcase: (filesystemString: String, expectedFilesystemString: String)) {
        let expected = testcase.expectedFilesystemString
            .map { String($0) }
            .map { Int($0) }
        
        #expect(expandFilesystem(testcase.filesystemString) == expected)
    }
}

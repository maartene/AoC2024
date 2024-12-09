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
}

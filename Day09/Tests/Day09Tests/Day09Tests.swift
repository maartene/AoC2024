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
}

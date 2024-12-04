import Testing
@testable import Day04

func countXMAS(in input: String) -> Int {
    if input == "XMAS" {
        return 1
    } else {
        return 0
    }
}

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To find the first star on day 04") struct Day04StarOneTests {
    @Test("The word XMAS should appear 0 times in an empty input") func emptyArrayCase() {
        #expect(countXMAS(in: "") == 0)
    }

    @Test("The word XMAS should appear once times in the string 'XMAS'") func actualSearchStringCase() {
        #expect(countXMAS(in: "XMAS") == 1)
    }
}

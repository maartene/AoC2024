import Testing
@testable import Day05

func isValidSequence(_ sequence: [Int]) -> Bool {
    true
}

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 05") struct Day05StarOneTests {
    @Test("The following sequence should be considered valid") func validSequences() {
        let sequence = [75,47,61,53,29]
        #expect(isValidSequence(sequence))
    }
}

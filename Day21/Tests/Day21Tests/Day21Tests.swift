import Testing
@testable import Day21

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 21") struct Day21StarOneTests {
    @Test("The complexity factor of the example input is 126384") func complexityFactorOfExampleInput() {
        let exampleInput =
        """
        029A
        980A
        179A
        456A
        379A
        """
        
        #expect(complexityFactor(of: exampleInput) == 126384)
    }
}

import Testing
@testable import Day14

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 14") struct Day14StarOneTests {
    @Test("The safety factor for the example input should be 12") func safetyFactorForExampleInput() {
        let exampleInput =
        """
        p=0,4 v=3,-3
        p=6,3 v=-1,-3
        p=10,3 v=-1,2
        p=2,0 v=2,-1
        p=0,0 v=1,3
        p=3,0 v=-2,-2
        p=7,6 v=-1,-3
        p=3,0 v=-1,-2
        p=9,3 v=2,3
        p=7,3 v=-1,2
        p=2,4 v=2,-3
        p=9,5 v=-3,-3
        """
        #expect(safetyFactor(for: exampleInput) == 12)
    }
}

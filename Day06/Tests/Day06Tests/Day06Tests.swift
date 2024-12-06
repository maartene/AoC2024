import Testing
@testable import Day06

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 06") struct Day06StarOneTests {
    @Test("On a one by one map without obstacles the guard visits exactly one position") func oneByOneMapWithoutObstacles() {
        let map = "^"
        #expect(numberOfDistinctVisitedPositions(in: map) == 1) 
    }

    @Test("On a two by three map without obstacles the guard while starting at the bottom visits exactly three position") func twoByThreeMapWithoutObstacles() {
        let map = 
        """
        ...
        ...
        ..^
        """
        #expect(numberOfDistinctVisitedPositions(in: map) == 3) 
    }
}
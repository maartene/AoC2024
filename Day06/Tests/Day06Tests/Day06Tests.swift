import Testing
@testable import Day06

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 06") struct Day06StarOneTests {
    @Test("On a map without obstacles, when the guard starts at the bottom, the number of visited distinct locations is the height of the map", arguments: [
        ("^", 1),
        ("""
        ...
        ...
        ..^
        """, 3),
        ("""
        ...
        ..^
        """, 2),
    ]) func MbyNMapWithoutObstaclesWhileGuardStartAtTheBottom(testcase: (map: String, expected: Int)) {
        #expect(numberOfDistinctVisitedPositions(in: testcase.map) == testcase.expected)
    }

    @Test("On a map without obstacles, when the guard does not start at the bottom, the number of visited distinct locations is the position of the guard", arguments: [
        ("""
        ...
        .^.
        ...
        """, 2),
        ("""
        .^.
        ...
        """, 1),
        ("""
        .^.
        ...
        ...
        """, 1)
    ]) func MbyNMapWithoutObstaclesWhileGuardDoesNotStartAtTheBottom(testcase: (map: String, expected: Int)) {
        #expect(numberOfDistinctVisitedPositions(in: testcase.map) == testcase.expected)
    }

}
import Testing
@testable import Day06

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

    @Test("On a map without obstacles, when the guard does not start at the bottom, the number of visited distinct locations is the height of the map minus how far 'in' the guard is", arguments: [
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

    @Test("we will need to get the correct amount of distinct tiles also on maps with obstacles", arguments: [
        ("""
        ..#
        ...
        ..^
        """, 2),
        ("""
        ...
        ..#
        ..^
        """, 1),
        ("""
        ...
        .#.
        ..^
        """, 3)
    ]) func correctCountForMapWithObstacles(testcase: (map: String, expected: Int)) {
        #expect(numberOfDistinctVisitedPositions(in: testcase.map) == testcase.expected)
    }

}
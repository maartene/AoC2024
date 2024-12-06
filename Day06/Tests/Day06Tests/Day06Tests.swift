import Testing
@testable import Day06

let exampleInput =
    """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

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
        """, 3),
        ("""
        ...
        ..^
        ..#
        """, 2)
    ]) func correctCountForMapWithObstacles(testcase: (map: String, expected: Int)) {
        #expect(numberOfDistinctVisitedPositions(in: testcase.map) == testcase.expected)
    }

    @Test("we will need to get the correct amount of distinct tiles also on maps where we need to change directions", arguments: [
        ("""
        .#.
        ...
        .^.
        """, 3),
        ("""
        .#..#
        ....#
        .^...
        .....
        ...##
        """, 9)
    ]) func correctCountForMapWhereWeNeedToChangeDirections(testcase: (map: String, expected: Int)) {
        #expect(numberOfDistinctVisitedPositions(in: testcase.map) == testcase.expected)
    }

    @Test("we will need to get the correct amount of distinct tiles also on maps where we need to change directions and cross") func correctCountForMapWithCrossing() {
        let map = 
        """
        #..
        ..#
        ...
        ^#.
        """
        #expect(numberOfDistinctVisitedPositions(in: map) == 5)
    }

    @Test("The number of distinct visited positions in the example input should be 41") func distinctNumberOfVisitedPositions_exampleInput() {
        #expect(numberOfDistinctVisitedPositions(in: exampleInput) == 41)
    }

    @Test("The number of distinct visited positions in the actual input should be 5318") func distinctNumberOfVisitedPositions_actualInput() {
        #expect(numberOfDistinctVisitedPositions(in: input) == 5318)
    }
}

@Suite("To get the second star on Day 06") struct Day06StarTwoTests {
    @Test("the guard is trapped in this map") func guardIsTrapped() {
        let mapString = 
        """
        .#..
        ....#
        #^...
        ...#.
        """
        let map = Map(mapString)
        #expect(guardIsTrappedInLoop(map: map))
    }
    // @Test("the number of places where an obstruction can be placed to trap a guard in a loop for the example input is 6") func numberOfObstacles_forExampleInput() {
    //     #expect(numberOfPositionsForObstructions(in: exampleInput) == 6)
    // }
}
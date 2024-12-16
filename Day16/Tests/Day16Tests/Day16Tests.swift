import Testing
@testable import Day16

let firstExampleMap = 
        """
        ###############
        #.......#....E#
        #.#.###.#.###.#
        #.....#.#...#.#
        #.###.#####.#.#
        #.#.#.......#.#
        #.#.#####.###.#
        #...........#.#
        ###.#.#####.#.#
        #...#.....#.#.#
        #.#.#.###.#.#.#
        #.....#...#.#.#
        #.###.#.#.#.#.#
        #S..#.....#...#
        ###############
        """

let secondExampleMap = 
    """
    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#.#
    #.#.#.#...#...#.#
    #.#.#.#.###.#.#.#
    #...#.#.#.....#.#
    #.#.#.#.#.#####.#
    #.#...#.#.#.....#
    #.#.#####.#.###.#
    #.#.#.......#...#
    #.#.###.#####.###
    #.#.#...#.....#.#
    #.#.#.#####.###.#
    #.#.#.........#.#
    #.#.#.#########.#
    #S#.............#
    #################
    """

@Suite("To get the first star on day 16") struct Day16StarOneTests {
    @Test("The lowest score on the example maps should be as expected", arguments: [
        (firstExampleMap, 7036),
        (secondExampleMap, 11048)
    ]) func lowestScoreOnExampleMaps(testcase: (mapString: String, expectedLowestScore: Int)) {
        #expect(lowestPossibleScore(in: testcase.mapString) == testcase.expectedLowestScore) 
    }

    @Test("The path with the lowest score in the example mazes should be as expected", arguments: [
        (firstExampleMap, (36, 7)),
        (secondExampleMap, (48, 11))
    ]) func stepsAndTurnsForLowestScoringPathInFirstExample(testcase: (mapString: String, stepsAndTurns: (Int, Int))) {
        #expect(stepsAndTurnsForLowestScore(in: testcase.mapString) == testcase.stepsAndTurns)
    }

    @Test("The path with the lowest score in the second example maze has moving forward 48 times and turning 11 times") func stepsAndTurnsForLowestScoringPathInSecondExample() {
        #expect(stepsAndTurnsForLowestScore(in: secondExampleMap) == (48, 11))
    }



}
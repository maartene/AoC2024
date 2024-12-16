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

    // @Test("The lowest score on the actual map should be 85420") func lowestScoreActualMap() {
    //     #expect(lowestPossibleScore(in: input) == 85420)
    // }

    @Test("The path with the lowest score in the example mazes should be as expected", arguments: [
        (firstExampleMap, (36, 7)),
        (secondExampleMap, (48, 11))
    ]) func stepsAndTurnsForLowestScoringPathInFirstExample(testcase: (mapString: String, stepsAndTurns: StepsAndTurns)) {
        #expect(stepsAndTurnsForLowestScore(in: testcase.mapString) == testcase.stepsAndTurns)
    }
}
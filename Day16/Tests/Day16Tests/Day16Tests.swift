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
}

@Suite("To get the second star in day 16") struct Day16StarTwoTests {
    @Test("For the first example, 45 tiles are part of one of the best paths") func numberOfBestSpotsInFirstExampleMaze() {
        #expect(numberOfBestPaths(through: firstExampleMap) == 45)
    }

    @Test("For the second example, 64 tiles are part of one of the best paths") func numberOfBestSpotsInSecondExampleMaze() {
        #expect(numberOfBestPaths(through: secondExampleMap) == 64)
    }

    @Test("For this symmetric map, 8 tiles are part of one of the best paths") func symmetricSmallMap() {
        let map = 
        """
        #####
        #...#
        #S#E#
        #...#
        #####
        """

        #expect(numberOfBestPaths(through: map) == 8)
    }

    @Test("For the actual input, the number of optimal seats should be 492") func optimalSeatsActualInput() {
        #expect(numberOfBestPaths(through: input) == 492)
    }
}
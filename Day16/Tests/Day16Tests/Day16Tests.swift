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
    @Test("The lowest score possible on the first map should be 7036") func lowestScoreOnFirstMap() {
        #expect(lowestPossibleScore(in: firstExampleMap) == 7036) 
    }

    // @Test("The lowest score possible on the second example map should be 11048") func lowestScoreOnSecondMap() {
    //     

    //     #expect(lowestPossibleScore(in: secondExampleMap) == 11048) 
    // }

    @Test("The path with the lowest score in the first example maze has moving forward 36 times and 7 turns") func stepsAndTurnsForLowestScoringPathInFirstExample() {
        #expect(stepsAndTurnsForLowestScore(in: firstExampleMap) == (36, 7))
    }

    @Test("The path with the lowest score in the second example maze has moving forward 48 times and turning 11 times") func stepsAndTurnsForLowestScoringPathInSecondExample() {
        #expect(stepsAndTurnsForLowestScore(in: secondExampleMap) == (48, 11))
    }



}
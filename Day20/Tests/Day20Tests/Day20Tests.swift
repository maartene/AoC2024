import Testing
import Shared
@testable import Day20

let exampleInput =
    """
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
    """

@Suite("To get the first star on day 20") struct Day20StarOneTests {
    @Test("There are a number of cheats in the example input that saves at least certain picoseconds", arguments: [
        (64, 1),
        (40, 2),
        (38, 3),
        (36, 4),
        (20, 5),
        (12, 8),
        (10, 10),
        (8, 14),
        (6, 16),
        (4, 30),
        (2, 44)
    ]) func picoSecondsSavedInTheExampleInput(testCase: (minimumPicoSecondsSaved: Int, expectedNumberOfCheats: Int)) {
        #expect(numberOfCheatsThatSaveAtLeast(picoSeconds: testCase.minimumPicoSecondsSaved, in: exampleInput) == testCase.expectedNumberOfCheats)
    }
    
    @Test("There are 1490 number of cheats in the actual input that saves at least 100 picoseconds") func picoSecondsSavedInActualInput() {
        #expect(numberOfCheatsThatSaveAtLeast(picoSeconds: 100, in: input) == 1490)
    }
}

@Suite("To get the second star on day 20") struct Day20StarTwoTests {
    
    
    @Test("There are 1011325 number of cheats in the actual input that saves at least 100 picoseconds") func picoSecondsSavedInActualInput() {
        #expect(numberOfCheatsThatSaveAtLeast(picoSeconds: 100, in: input, maxCheats: 20) == 1011325)
    }
}

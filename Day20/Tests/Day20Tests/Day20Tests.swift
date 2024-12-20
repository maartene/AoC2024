import Testing
@testable import Day20

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 20") struct Day20StarOneTests {
    @Test("There are a number of cheats in the example input that saves at least certain picoseconds", arguments: [
        (64, 1),
        (40, 2),
        (38, 3),
    ]) func picoSecondsSavedInTheExampleInput(testCase: (minimumPicoSecondsSaved: Int, expectedNumberOfCheats: Int)) {
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
        
        #expect(numberOfCheatsThatSaveAtLeast(picoSeconds: testCase.minimumPicoSecondsSaved, in: exampleInput) == testCase.expectedNumberOfCheats)
    }
}

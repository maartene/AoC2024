import Testing
@testable import Day20

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 20") struct Day20StarOneTests {
    @Test("There is one cheat in the example input that saves 64 picoseconds") func picoSecondsSavedInTheExampleInput() {
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
        
        #expect(numberOfCheatsThatSaveAtLeast(picoSeconds: 64, in: exampleInput) == 1)
    }
}

import Testing
@testable import Day25

@Suite("To get the first star on day 25") struct Day25StarOneTests {
    @Test("The number of unique lock/key pairs that fit in the example input should be 3") func uniqueLockKeyPairs_inExampleInput() {
        let exampleInput =
        """
        #####
        .####
        .####
        .####
        .#.#.
        .#...
        .....

        #####
        ##.##
        .#.##
        ...##
        ...#.
        ...#.
        .....

        .....
        #....
        #....
        #...#
        #.#.#
        #.###
        #####

        .....
        .....
        #.#..
        ###..
        ###.#
        ###.#
        #####

        .....
        .....
        .....
        #....
        #.#..
        #.#.#
        #####
        """
        
        #expect(uniqueLockKeyPairsIn(exampleInput) == 3)
    }
}

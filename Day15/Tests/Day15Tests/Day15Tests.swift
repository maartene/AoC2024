import Testing
import Shared
@testable import Day15

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

let smallExample =
    """
    ########
    #..O.O.#
    ##@.O..#
    #...O..#
    #.#.O..#
    #...O..#
    #......#
    ########

    <^^>>>vv<v>>v<<
    """

@Suite("To get the first star on day 15") struct Day15StarOneTests {
//    @Test("The sum of all the boxes' GPS coordinates in the small example should be 2028") func sumOfAllBoxesInSmallExample() {
//        #expect(sumOfAllBoxesApplying(smallExample) == 2028)
//    }
    
    @Test("The sum of all the boxes' GPS coordinates in the end state of the small example should be 2028") func sumOfAllBoxesInEndStateOfSmallExample() {
        let endState =
        """
        ########
        #....OO#
        ##.....#
        #.....O#
        #.#O@..#
        #...O..#
        #...O..#
        ########
        """
        
        #expect(sumOfAllBoxesApplying(endState) == 2028)
    }
    
    @Test("The sum of all the boxes' GPS coordinates in the end state of the larger example should be 10092") func sumOfAllBoxesInEndStateOfLargerExample() {
        let endState =
        """
        ##########
        #.O.O.OOO#
        #........#
        #OO......#
        #OO@.....#
        #O#.....O#
        #O.....OO#
        #O.....OO#
        #OO....OO#
        ##########
        """
        
        #expect(sumOfAllBoxesApplying(endState) == 10092)
    }
    
    @Test("After applying the first N step for the smaller example, the correct state should be shown", arguments: [
        ("<",
            """
            ########
            #..O.O.#
            ##@.O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """),
        ("<^",
            """
            ########
            #.@O.O.#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """)
    ]) func firstStepForSmallExample(testcase: (instructionString: String, expectedState: String)) {
        var map = Map(smallExample)
        
        let instructions: [Character] = testcase.instructionString.map { $0 }
        for instruction in instructions {
            map = map.applyStep(instruction: instruction)
        }
        
        #expect(map.toString == testcase.expectedState)
    }
}

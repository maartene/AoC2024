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
    
    @Test("After applying the first step for the smaller example, the correct state should be shown") func firstStepForSmallExample() {
        let expectedState =
        """
        ########
        #..O.O.#
        ##@.O..#
        #...O..#
        #.#.O..#
        #...O..#
        #......#
        ########
        """
        
        let map = Map(smallExample)
        
        let result = map.applyStep(instruction: ">").toString
        print(result)
        print(expectedState)
        #expect(result == expectedState)
    }
}

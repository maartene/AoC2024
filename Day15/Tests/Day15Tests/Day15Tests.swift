import Testing
@testable import Day15

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 15") struct Day15StarOneTests {
//    @Test("The sum of all the boxes' GPS coordinates in the small example should be 2028") func sumOfAllBoxesInSmallExample() {
//        let smallExample =
//        """
//        ########
//        #..O.O.#
//        ##@.O..#
//        #...O..#
//        #.#.O..#
//        #...O..#
//        #......#
//        ########
//        
//        <^^>>>vv<v>>v<<
//        """
//        
//        #expect(sumOfAllBoxesApplying(smallExample) == 2028)
//    }
    
    @Test("The sum of all the boxes' GPS coordinates in the end state of the small example should be 2028") func sumOfALlBoxesInLargerExample() {
        let endState =
        """
        "########
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
}

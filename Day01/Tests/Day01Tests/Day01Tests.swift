import Testing
@testable import Day01

@Suite("To find the first star on Day01") struct Day01FirstStarTests {
    @Test("the total difference between on a one line number list should be the difference between those two numbers", arguments: [
        ("1 3", 2),
        ("4 4", 0),
    ]) func oneLineNumberList(testCase: (input: String, expectedTotalDistance: Int)) {
        #expect(totalDistanceBetweenLists(testCase.input) == testCase.expectedTotalDistance)
    }
    
    @Test("the total difference between a two line number list should be the difference between pairing the lowest numbers added together") func twoLineNumberList() {
        let input =
        """
        4 3
        1 4
        """
        #expect(totalDistanceBetweenLists(input) == 2)
    }
    
    @Test("the total difference for the example input should be 11") func starOneExample() {
        let input =
        """
        3   4
        4   3
        2   5
        1   3
        3   9
        3   3
        """
        
        #expect(totalDistanceBetweenLists(input) == 11)
    }
    
    @Test("the total difference for the actual input should be 2580760") func starOneActual() {
        #expect(totalDistanceBetweenLists(input) == 2580760)
    }
}

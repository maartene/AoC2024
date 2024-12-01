import Testing
@testable import Day01

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}


func totalDistanceBetweenLists(_ input: String) -> Int {
    var leftList = [Int]()
    var rightList = [Int]()
    
    let lines = input.split(separator: "\n")
    for line in lines {
        let lists = line.split(separator: " ")
            .compactMap { Int($0) }
        
        leftList.append(lists[0])
        rightList.append(lists[1])
    }
    
    leftList.sort()
    rightList.sort()
    
    return zip(leftList, rightList).reduce(0) { partialResult, zipSequence in
        partialResult + abs(zipSequence.0 - zipSequence.1)
    }
}

@Suite("To find the first star on Day01") struct Day01Tests {
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

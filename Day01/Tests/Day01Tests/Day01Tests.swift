import Testing
@testable import Day01

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}


func totalDistanceBetweenLists(_ input: String) -> Int {
    2
}

@Suite("To find the first star on Day01") struct Day01Tests {
    @Test("the total difference between on a one number list should be the difference between those two numbers", arguments: [
        ("1 3", 2),
 //       ("4 4", 0),
    ]) func oneNumberList(testCase: (input: String, expectedTotalDistance: Int)) {
        #expect(totalDistanceBetweenLists(testCase.input) == testCase.expectedTotalDistance)
    }
}

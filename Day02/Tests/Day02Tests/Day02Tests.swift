import Testing
@testable import Day02

func reportIsSafe(_ report: [Int]) -> Bool {
    true
}

@Suite("To find the first star on day 2") struct Day02Star1Tests {
    let exampleInput =
    """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """
    
    @Test("we should be able to determine whether a report is safe or not", arguments: [
        ([7, 6, 4, 2, 1], true),
        
    ]) func testIfReportIsSafe(testcase: (report: [Int], isSafe: Bool)) {
        #expect(reportIsSafe(testcase.report) == testcase.isSafe)
    }
}

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

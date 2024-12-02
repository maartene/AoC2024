import Testing

@testable import Day02

func reportIsSafeWithDampener(_ report: [Int]) -> Bool {
    guard reportIsSafe(report) == false else {
        return true
    }
    
    for i in 0 ..< report.count {
        var dampenedReport = [Int]()
        for j in 0 ..< report.count {
            if j != i {
                dampenedReport.append(report[j])
            }
        }
        
        if reportIsSafe(dampenedReport) {
            return true
        }
    }
    
    return false
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

    @Test(
        "we should be able to determine whether a report is safe or not",
        arguments: [
            ([7, 6, 4, 2, 1], true),
            ([1, 2, 7, 8, 9], false),
            ([9, 7, 6, 2, 1], false),
            ([1, 3, 2, 4, 5], false),
            ([8, 6, 4, 4, 1], false),
            ([1, 3, 6, 7, 9], true),
        ]) func testIfReportIsSafe(testcase: (report: [Int], isSafe: Bool))
    {
        print("Testing: \(testcase.report), expecting \(testcase.isSafe)")
        #expect(reportIsSafe(testcase.report) == testcase.isSafe)
    }

    @Test("the number of safe reports in the example input should be 2")
    func safeReportsInExampleInput() {
        #expect(numberOfSafeReports(exampleInput) == 2)
    }

    @Test("the number of safe reports in the input should be 631") func safeReportsInInput() {
        #expect(numberOfSafeReports(input) == 631)
    }
}

@Suite("To find the second star on day 2") struct Day02Star2Tests {
    let exampleInput =
        """
        7 6 4 2 1
        1 2 7 8 9
        9 7 6 2 1
        1 3 2 4 5
        8 6 4 4 1
        1 3 6 7 9
        """
    
    @Test(
        "we should be able to determine whether a report is safe or not",
        arguments: [
            ([7, 6, 4, 2, 1], true),
            ([1, 2, 7, 8, 9], false),
            ([9, 7, 6, 2, 1], false),
            ([1, 3, 2, 4, 5], true),
            ([8, 6, 4, 4, 1], true),
            ([1, 3, 6, 7, 9], true),
        ]) func testIfReportIsSafe(testcase: (report: [Int], isSafe: Bool))
    {
        #expect(reportIsSafeWithDampener(testcase.report) == testcase.isSafe)
    }
}

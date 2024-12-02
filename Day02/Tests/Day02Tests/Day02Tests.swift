import Shared
import Testing

@testable import Day02

func numberOfSafeReports(_ input: String) -> Int {
    let reports = convertStringToIntMatrix(input)
    
    return
        reports
        .filter {
            reportIsSafe($0)
        }
        .count
}

func reportIsSafe(_ report: [Int]) -> Bool {
    // Are the differences in order?
    for i in 0..<report.count - 1 {
        let difference = abs(report[i] - report[i + 1])
        if difference < 1 || difference > 3 {
            return false
        }
    }

    // Is the direction uniform?
    let increasing = report[0] < report[1]
    let decreasing = increasing == false
    for i in 1..<report.count {
        if increasing && report[i] < report[i - 1] {
            return false
        } else if decreasing && report[i] > report[i - 1] {
            return false
        }
    }

    return true
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

import Shared

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

func numberOfSafeReportsWithDampener(_ input: String) -> Int {
    let reports = convertStringToIntMatrix(input)
    
    return
        reports
        .filter {
            reportIsSafeWithDampener($0)
        }
        .count
}

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

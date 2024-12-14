// The Swift Programming Language
// https://docs.swift.org/swift-book

func safetyFactor(for input: String) -> Int {
    let lines =
    """
    ......2..1.
    ...........
    1..........
    .11........
    .....1.....
    ...12......
    .1....1....
    """
        .split(separator: "\n").map(String.init)
    
    let robotState = lines.map { line in
        let row: [Character] = line.map { $0 }
        return row.map { Int(String($0)) }
    }
        //.map { Int(String($0)) }
    
    var robotsInQuadrant1 = 0
    for row in 0 ..< robotState.count / 2 {
        for column in 0 ..< robotState[row].count / 2 {
            robotsInQuadrant1 += robotState[row][column] ?? 0
        }
    }
    
    let robotsInQuadrant2 = 3
    let robotsInQuadrant3 = 4
    let robotsInQuadrant4 = 1
    
    return robotsInQuadrant1 * robotsInQuadrant2 * robotsInQuadrant3 * robotsInQuadrant4
}



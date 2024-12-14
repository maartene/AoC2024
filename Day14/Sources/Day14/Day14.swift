// The Swift Programming Language
// https://docs.swift.org/swift-book

func safetyFactor(for input: String) -> Int {
    let robotState =
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
        .map { line in
            let row: [Character] = line.map { $0 }
            return row.map { Int(String($0)) }
        }
    
    func getRobotsInQuadrant(in robotState: [[Int?]], for quadrant: Int) -> Int {
        let bounds: (rowStart: Int, rowEnd: Int, columnStart: Int, columnEnd: Int) = switch quadrant {
        case 1: (rowStart: 0, rowEnd: robotState.count / 2, columnStart: 0, columnEnd: robotState[0].count / 2)
        case 2: (rowStart: 0, rowEnd: robotState.count / 2, columnStart: 1 + robotState[0].count / 2, columnEnd: robotState[0].count)
        case 3: (rowStart: 1 + robotState.count / 2, rowEnd: robotState.count, columnStart: 0, columnEnd: robotState[0].count / 2)
        case 4: (rowStart: 1 + robotState.count / 2, rowEnd: robotState.count, columnStart: 1 + robotState[0].count / 2, columnEnd: robotState[0].count)
        default:
            fatalError("Quadrant should be 1...4 but was \(quadrant).")
        }
        
        var robotsInQuantrant = 0
        
        for row in bounds.rowStart ..< bounds.rowEnd {
            for column in bounds.columnStart ..< bounds.columnEnd {
                robotsInQuantrant += robotState[row][column] ?? 0
            }
        }
        
        return robotsInQuantrant
    }
    
    let robotsInQuadrant1 = getRobotsInQuadrant(in: robotState, for: 1)
    let robotsInQuadrant2 = getRobotsInQuadrant(in: robotState, for: 2)
    let robotsInQuadrant3 = getRobotsInQuadrant(in: robotState, for: 3)
    let robotsInQuadrant4 = getRobotsInQuadrant(in: robotState, for: 4)
    
    
    return robotsInQuadrant1 * robotsInQuadrant2 * robotsInQuadrant3 * robotsInQuadrant4
}



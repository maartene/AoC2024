import Shared

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
    
    let robotStateAfter100Seconds = advanceTime(initialState: robotState, seconds: 100)
    
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
    
    let robotsInQuadrant1 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 1)
    let robotsInQuadrant2 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 2)
    let robotsInQuadrant3 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 3)
    let robotsInQuadrant4 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 4)
    
    
    return robotsInQuadrant1 * robotsInQuadrant2 * robotsInQuadrant3 * robotsInQuadrant4
}

func advanceTime(initialState: [[Int?]], seconds: Int) -> [[Int?]] {
    initialState
}



/// Stash
/// // convert input to robotState
//let lines = input.split(separator: "\n").map(String.init)
//
//var robots: [(positing: Vector, velocity: Vector)] = []
//for line in lines {
//    let numbers = line.matches(of: /\d+/)
//        .map { String($0.0) }
//        .compactMap(Int.init)
//    let robot = (Vector(x: numbers[0], y: numbers[1]), Vector(x: numbers[2], y: numbers[3]))
//    robots.append(robot)
//}

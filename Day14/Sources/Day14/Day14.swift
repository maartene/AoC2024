import Shared

struct Robot {
    let position: Vector
    let velocity: Vector
}

func safetyFactor(for input: String, size: Vector) -> Int {
    
    
    let characters =
    convertInputToMatrixOfCharacters(
    """
    ......2..1.
    ...........
    1..........
    .11........
    .....1.....
    ...12......
    .1....1....
    """
    )
    var robotState = [Robot]()
    for y in 0 ..< characters.count {
        for x in 0 ..< characters[y].count {
            if let robotCount = Int(String(characters[y][x])) {
                let robot = Robot(position: Vector(x: x, y: y), velocity: Vector(x: 0, y: 0))
                robotState.append(contentsOf: Array(repeating: robot, count: robotCount))
            }
        }
    }
    
    let robotStateAfter100Seconds = advanceTime(initialState: robotState, seconds: 100)
    
    func getRobotsInQuadrant(in robotState: [Robot], for quadrant: Int, mapSize: Vector) -> Int {
        let bounds: (rowStart: Int, rowEnd: Int, columnStart: Int, columnEnd: Int) = switch quadrant {
        case 1: (rowStart: 0, rowEnd: mapSize.y / 2, columnStart: 0, columnEnd: mapSize.x / 2)
        case 2: (rowStart: 0, rowEnd: mapSize.y / 2, columnStart: 1 + mapSize.x / 2, columnEnd: mapSize.x)
        case 3: (rowStart: 1 + mapSize.y / 2, rowEnd: mapSize.y, columnStart: 0, columnEnd: mapSize.x / 2)
        case 4: (rowStart: 1 + mapSize.y / 2, rowEnd: mapSize.y, columnStart: 1 + mapSize.x / 2, columnEnd: mapSize.x)
        default:
            fatalError("Quadrant should be 1...4 but was \(quadrant).")
        }
        
        var robotsInQuantrant = 0
        
        for row in bounds.rowStart ..< bounds.rowEnd {
            for column in bounds.columnStart ..< bounds.columnEnd {
                let robotsOnLocation = robotState.filter { $0.position == Vector(x: column, y: row) }.count
                robotsInQuantrant += robotsOnLocation
            }
        }
        
        return robotsInQuantrant
    }
    
    let robotsInQuadrant1 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 1, mapSize: size)
    let robotsInQuadrant2 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 2, mapSize: size)
    let robotsInQuadrant3 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 3, mapSize: size)
    let robotsInQuadrant4 = getRobotsInQuadrant(in: robotStateAfter100Seconds, for: 4, mapSize: size)
    
    
    return robotsInQuadrant1 * robotsInQuadrant2 * robotsInQuadrant3 * robotsInQuadrant4
}

func advanceTime(initialState: [Robot], seconds: Int) -> [Robot] {
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

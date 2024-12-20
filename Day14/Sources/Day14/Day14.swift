import Shared
import Foundation


@main struct EscapeWithYourBooty {
    static func main() {
        var robotState = parseInputIntoRobotState(input: input)
        let mapSize = Vector(x: 101, y: 103)
        var positionCount = Set(robotState.map { $0.position } ).count
        var stepCount = 0
        while positionCount != robotState.count {
            stepCount += 1
            robotState = step(state: robotState, mapSize: mapSize)
            positionCount = Set(robotState.map { $0.position } ).count
        }
        
        print("X-Mas at step \(stepCount)")
        printRobotState(robotState: robotState, mapSize: mapSize)
    }
}

func timeUntilChristmasTree(_ input: String) -> Int {
    func getStandardDeviation(robotState: [Robot]) -> Double {
        let midPoint = robotState.map { $0.position }
            .reduce(Vector.zero, +)
        / robotState.count
        
        let distanceFromCenter = robotState.map { robot in
            (robot.position - midPoint / 2).length
        }
        
        let averageDistanceFromCenter = distanceFromCenter.reduce(0) { partialResult, distance in
            partialResult + distance
        } / Double(distanceFromCenter.count)
        
        let squaredError = distanceFromCenter.reduce(0) { partialResult, distance in
            let error = distance - averageDistanceFromCenter
            return partialResult + error * error / Double(distanceFromCenter.count)
        }
        
        return sqrt(squaredError)
    }
    
    var robotState = parseInputIntoRobotState(input: input)
    let mapSize = Vector(x: 101, y: 103)
    
    // calculate standard deviation
    var standardDeviation = getStandardDeviation(robotState: robotState)
    
    var deviations = [Int: Double]()
    
    for i in 0 ..< mapSize.x * mapSize.y {
        deviations[i] = standardDeviation
        robotState = step(state: robotState, mapSize: mapSize)
        standardDeviation = getStandardDeviation(robotState: robotState)
    }
    
    return deviations.min(by: { $0.value < $1.value} )?.key ?? 0
}

struct Robot {
    let position: Vector
    let velocity: Vector
    
    func step(mapSize: Vector) -> Robot {
        var newPosition = position + velocity + mapSize
        newPosition.x = newPosition.x % mapSize.x
        newPosition.y = newPosition.y % mapSize.y
        return Robot(position: newPosition, velocity: velocity)
    }
}

func printRobotState(robotState: [Robot], mapSize: Vector) {
    for y in 0 ..< mapSize.y {
        var line = ""
        for x in 0 ..< mapSize.x {
            if robotState.contains(where: { $0.position == Vector(x: x, y: y) }) {
                line += "\u{2588}"
            } else {
                line += " "
            }
        }
        print(line)
    }
}

func safetyFactor(for input: String, size: Vector) -> Int {
    let robotState = parseInputIntoRobotState(input: input)
    
    let robotStateAfter100Seconds = advanceTime(initialState: robotState, seconds: 100, mapSize: size)
    
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

func step(state: [Robot], mapSize: Vector) -> [Robot] {
    state.map { $0.step(mapSize: mapSize) }
}

func advanceTime(initialState: [Robot], seconds: Int, mapSize: Vector) -> [Robot] {
    var robotState = initialState
    for _ in 0 ..< seconds {
        robotState = step(state: robotState, mapSize: mapSize)
    }
    return robotState
}


func parseInputIntoRobotState(input: String) -> [Robot] {
    let lines = input.split(separator: "\n").map { String($0) }
    
    var robotState = [Robot]()
    for line in lines {
        let numbers = line.matches(of: /-*\d+/)
            .map { String($0.0) }
            .compactMap(Int.init)
        let robot = Robot(position: Vector(x: numbers[0], y: numbers[1]), velocity: Vector(x: numbers[2], y: numbers[3]))
        robotState.append(robot)
    }
    
    return robotState
}

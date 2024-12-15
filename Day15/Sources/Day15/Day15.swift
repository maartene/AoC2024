import Shared

func sumOfAllBoxesApplying(_ input: String, expand: Bool = false) -> Int {
    var input = input
    if expand {
        input = input.replacingOccurrences(of: "#", with: "##")
        input = input.replacingOccurrences(of: "O", with: "[]")
        input = input.replacingOccurrences(of: ".", with: "..")
        input = input.replacingOccurrences(of: "@", with: "@.")
    }
    
    var map = Map(input)
    
    let instructionString = input.split(separator: "\n")
        .map(String.init)
        .filter { $0.first != "#" }
        .joined()
    
    let instructions: [Character] = convertStringToInstructions(instructionString)
    map = map.applyInstructions(instructions)
    
    let obstacles = map.obstacles.filter { $0.value == "O" || $0.value == "[" }
    
    let coordinates = obstacles.map { $0.key.x + 100 * $0.key.y }
    
    return coordinates.reduce(0, +)
}

struct Map {
    let walls: Set<Vector>
    let obstacles: [Vector: Character]
    let playerPosition: Vector
    let mapSize: Vector
    
    private init(walls: Set<Vector>, obstacles: [Vector: Character], playerPosition: Vector, mapSize: Vector) {
        self.walls = walls
        self.obstacles = obstacles
        self.playerPosition = playerPosition
        self.mapSize = mapSize
    }
    
    init(_ input: String) {
        // remove rows that are not part of the map
        let matrix = convertInputToMatrixOfCharacters(input)
            .filter { $0.first == "#" }
        
        var walls = Set<Vector>()
        var obstacles = [Vector: Character]()
        var playerPosition = Vector.zero
        for y in 0 ..< matrix.count {
            for x in 0 ..< matrix[y].count {
                switch matrix[y][x] {
                case "#": walls.insert(Vector(x: x, y: y))
                case "O": obstacles[Vector(x: x, y: y)] = "O"
                case "[": obstacles[Vector(x: x, y: y)] = "["
                case "]": obstacles[Vector(x: x, y: y)] = "]"
                case "@": playerPosition = Vector(x: x, y: y)
                default:
                    break
                }
            }
        }
        
        self.walls = walls
        self.obstacles = obstacles
        self.playerPosition = playerPosition
        self.mapSize = Vector(x: matrix[0].count, y: matrix.count)
    }
    
    var toString: String {
        var result = ""
        for y in 0 ..< mapSize.y {
            var line = ""
            for x in 0 ..< mapSize.x {
                let coord = Vector(x: x, y: y)
                if let obstacle = obstacles[coord] {
                    line += String(obstacle)
                } else if walls.contains(coord){
                    line += "#"
                } else if coord == playerPosition {
                    line += "@"
                } else {
                    line += "."
                }
            }
            line += "\n"
            result += line
        }
        
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func applyInstructions(_ instructions: [Character]) -> Map {
        var updatedMap = self
        
        for instruction in instructions {
            updatedMap = updatedMap.applyStep(instruction: instruction)
        }
        
        return updatedMap
    }
    
    
    func applyStep(instruction: Character) -> Map {
        var direction = Vector.zero
        switch instruction {
        case "<":
            direction.x -= 1
        case ">":
            direction.x += 1
        case "^":
            direction.y -= 1
        case "v":
            direction.y += 1
        default:
            break
        }
        
        let newPlayerPosition = self.playerPosition + direction
        
        if walls.contains(newPlayerPosition) {
            return self
        } else if obstacles.keys.contains(newPlayerPosition) {
            return tryMoveObstacle(direction: direction) ?? self
        } else {
            return Map(walls: walls, obstacles: obstacles, playerPosition: newPlayerPosition, mapSize: mapSize)
        }
    }
    
    private func tryMoveObstacle(direction: Vector) -> Map? {
        guard let boxesToShift = findBoxesToShift(direction: direction) else {
            return nil
        }
        
        let newPlayerPosition = self.playerPosition + direction
        let movedBoxes = createNewObstaclesSet(direction: direction, boxesToShift: boxesToShift)

        return Map(walls: walls, obstacles: movedBoxes, playerPosition: newPlayerPosition, mapSize: mapSize)
    }
    
    private func findBoxesToShift(direction: Vector) -> [Vector: Character]? {
        var boxesToShift = [Vector: Character]()
        
        var testPosition = playerPosition + direction
        
        var boxesToCheck = Set([testPosition])
        var visited = Set<Vector>()

        while boxesToCheck.isEmpty == false {
            testPosition = boxesToCheck.removeFirst()
            visited.insert(testPosition)
            
            while let obstacle = obstacles[testPosition] {
                boxesToShift[testPosition] = obstacles[testPosition]
                
                if let additionalTestPosition = additionalTestPositionWhenMovingWideBoxesInUpAndDown(obstacle: obstacle, testPosition: testPosition, direction: direction, visited: visited) {
                    boxesToCheck.insert(additionalTestPosition)
                }
                
                testPosition += direction
                if walls.contains(testPosition) {
                    return nil
                }
            }
        }
        
        return boxesToShift
    }
    
    private func createNewObstaclesSet(direction: Vector, boxesToShift: [Vector: Character]) -> [Vector: Character] {
        var obstaclesCopy = obstacles
        obstaclesCopy.removeValue(forKey: playerPosition + direction)

        for boxToShift in boxesToShift {
            obstaclesCopy.removeValue(forKey: boxToShift.key)
        }
        
        for boxToShift in boxesToShift {
            obstaclesCopy[boxToShift.key + direction] = boxToShift.value
        }
        
        return obstaclesCopy
    }
    
    private func additionalTestPositionWhenMovingWideBoxesInUpAndDown(obstacle: Character, testPosition: Vector, direction: Vector, visited: Set<Vector>) -> Vector? {
        guard (obstacle == "[" || obstacle == "]") && (direction == .down || direction == .up) else {
            return nil
        }
        
        var newTestPosition = testPosition
        
        if obstacle == "[" {
            newTestPosition = testPosition + .right
        } else {
            newTestPosition = testPosition + .left
        }
        
        if visited.contains(newTestPosition) == false {
            return newTestPosition
        }
        
        return nil
    }
}

func convertStringToInstructions(_ instructionString: String) -> [Character] {
    let instructions: [Character] = instructionString.map { $0 }.filter { ["^", "<", ">", "v"].contains($0) }
    return instructions
}

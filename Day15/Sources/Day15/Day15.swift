import Shared

func sumOfAllBoxesApplying(_ input: String) -> Int {
    var map = Map(input)
    
    let instructionString = input.split(separator: "\n")
        .map(String.init)
        .filter { $0.first != "#" }
        .joined()
    
    let instructions: [Character] = instructionString.map { $0 }.filter { ["^", "<", ">", "v"].contains($0) }
    for instruction in instructions {
        map = map.applyStep(instruction: instruction)
    }
    
    let obstacles = map.obstacles
    
    let coordinates = obstacles.map { $0.key.x + 100 * $0.key.y }
    
    return coordinates.reduce(0, +)
}

struct Map {
    let walls: Set<Vector>
    let obstacles: [Vector: Character]
    let playerPosition: Vector
    let mapSize: Vector
    
    init(walls: Set<Vector>, obstacles: [Vector: Character], playerPosition: Vector, mapSize: Vector) {
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
            return tryMoveObstacle(direction: direction)
        } else {
            return Map(walls: walls, obstacles: obstacles, playerPosition: newPlayerPosition, mapSize: mapSize)
        }
    }
    
    func tryMoveObstacle(direction: Vector) -> Map {
        var freePosition: Vector?
        
        var testPosition = playerPosition + direction
        while walls.contains(testPosition) == false && freePosition == nil {
            if obstacles.keys.contains(testPosition) == false {
                freePosition = testPosition
            }
            testPosition += direction
        }
        
        guard let freePosition else {
            return self
        }
        
        let newPlayerPosition = self.playerPosition + direction
        var obstaclesCopy = obstacles
        obstaclesCopy.removeValue(forKey: newPlayerPosition)
        obstaclesCopy[freePosition] = "O"
        return Map(walls: walls, obstacles: obstaclesCopy, playerPosition: newPlayerPosition, mapSize: mapSize)
    }
}

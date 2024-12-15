import Shared

func sumOfAllBoxesApplying(_ input: String) -> Int {
    let obstacles = Map(input).obstacles
    
    let coordinates = obstacles.map { $0.x + 100 * $0.y }
    
    return coordinates.reduce(0, +)
}

struct Map {
    let walls: Set<Vector>
    let obstacles: Set<Vector>
    let playerPosition: Vector
    let mapSize: Vector
    
    init(walls: Set<Vector>, obstacles: Set<Vector>, playerPosition: Vector, mapSize: Vector) {
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
        var obstacles = Set<Vector>()
        var playerPosition = Vector.zero
        for y in 0 ..< matrix.count {
            for x in 0 ..< matrix[y].count {
                switch matrix[y][x] {
                case "#": walls.insert(Vector(x: x, y: y))
                case "O": obstacles.insert(Vector(x: x, y: y))
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
                if obstacles.contains(coord) {
                    line += "O"
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
        } else if obstacles.contains(newPlayerPosition) {
            var obstaclesCopy = obstacles
            obstaclesCopy.remove(newPlayerPosition)
            obstaclesCopy.insert(newPlayerPosition + direction)
            return Map(walls: walls, obstacles: obstaclesCopy, playerPosition: newPlayerPosition, mapSize: mapSize)
        } else {
            return Map(walls: walls, obstacles: obstacles, playerPosition: newPlayerPosition, mapSize: mapSize)
        }
    }
}

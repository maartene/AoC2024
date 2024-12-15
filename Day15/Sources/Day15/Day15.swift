import Shared

func sumOfAllBoxesApplying(_ input: String) -> Int {
    let obstacles = Map(input).obstacles
    
    let coordinates = obstacles.map { $0.x + 100 * $0.y }
    
    return coordinates.reduce(0, +)
}

func applyStep(obstacles: Set<Vector>, instruction: Character) -> Set<Vector> {
    obstacles
}

func stateToString(obstacles: Set<Vector>, mapSize: Vector, walls: Set<Vector>, playerPosition: Vector) -> String {
    var result = ""
    for y in 0 ..< mapSize.y{
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

struct Map {
    let walls: Set<Vector>
    let obstacles: Set<Vector>
    let playerPosition: Vector
    
    init(_ input: String) {
        let matrix = convertInputToMatrixOfCharacters(input)
        
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
    }
}

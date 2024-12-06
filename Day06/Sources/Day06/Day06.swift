import Shared

enum Direction {
    case north, east, south, west
    
    var next: Direction {
        switch self {
        case .north:
            .east
        case .east:
            .south
        case .south:
            .west
        case .west:
            .north
        }
    }
}

func numberOfDistinctVisitedPositions(in mapString: String) -> Int {
    let map = interpretMap(mapString)
    let obstacles = map.obstacles
    var guardPosition = map.guardPosition
    var guardDirection = Direction.north

    var count = 0
    var whilebreaker = 0
    while map.isInsideMap(guardPosition) && whilebreaker < 1000 {
        whilebreaker += 1
        var newPosition = guardPosition 

        switch guardDirection {
            case .north:
                newPosition.y -= 1
            case .east:
                newPosition.x += 1
            case .south:
                newPosition.y += 1
            case .west: 
                newPosition.x -= 1
        }

        if obstacles.contains(newPosition) {
            guardDirection = guardDirection.next
        } else {
            guardPosition = newPosition
            count += 1
        }
    }

    return count
}

struct Map {
    let width: Int 
    let height: Int
    let obstacles: Set<Vector>
    let guardPosition: Vector

    func isInsideMap(_ coord: Vector) -> Bool {
        coord.x >= 0 && coord.x < width && coord.y >= 0 && coord.y < height
    }
}

func interpretMap(_ input: String) -> Map {
    let rows = input.split(separator: "\n").map(String.init)
    let width = rows.first?.count ?? 0

    var guardPosition = Vector.zero
    var obstacles = Set<Vector>() 
    for y in 0 ..< rows.count {
        let row = rows[y].map { $0 }
        for x in 0 ..< row.count {
            if row[x] == "#" {
                obstacles.insert(Vector(x: x, y: y))
            }
            if row[x] == "^" {
                guardPosition = Vector(x: x, y: y)
            }
        }
    }

    return Map(width: width, height: rows.count, obstacles: obstacles, guardPosition: guardPosition)
}
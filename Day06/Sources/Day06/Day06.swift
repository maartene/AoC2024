import Shared

enum Direction {
    case north, east, south, west
}

func numberOfDistinctVisitedPositions(in mapString: String) -> Int {
    let map = interpretMap(mapString)
    let obstacles = map.obstacles
    var guardPosition = map.guardPosition
    let width = map.width
    var guardDirection = Direction.north

    var count = 0
    while guardPosition.y >= 0  && guardPosition.x < map.width {
        var newPosition = guardPosition 

        switch guardDirection {
            case .north:
                newPosition.y -= 1
            case .east:
                newPosition.x += 1
            default:
                fatalError("Case not implemented yet")
        }

        if obstacles.contains(newPosition) {
            guardDirection = .east
        } else {
            guardPosition = newPosition
            count += 1
        }
    }

    return count
}

struct Map {
    let width: Int 
    let obstacles: Set<Vector>
    let guardPosition: Vector
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

    return Map(width: width, obstacles: obstacles, guardPosition: guardPosition)
}
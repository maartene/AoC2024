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
    let map = Map(mapString)
    let obstacles = map.obstacles
    var guardPosition = map.guardPosition
    var guardDirection = Direction.north

    var path: Set = [guardPosition]
    while map.isInsideMap(guardPosition) {
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
            path.insert(guardPosition)
        }
    }

    return path.filter { map.isInsideMap($0) }.count
}

func numberOfPositionsForObstructions(in mapString: String) -> Int {
    var map = Map(mapString)
    var count = 0
    for y in 0 ..< map.height {
        print("Testing row \(y)")
        for x in 0 ..< map.width {
            let possibleObstacleCoord = Vector(x: x, y: y)
            if map.obstacles.contains(possibleObstacleCoord) == false {
                map.obstacles.insert(possibleObstacleCoord)
                if guardIsTrappedInLoop(map: map) {
                    count += 1
                }
                map.obstacles.remove(possibleObstacleCoord)
            }
        }
    }

    return count
}

func guardIsTrappedInLoop(map: Map) -> Bool {
    struct PositionDirectionCombo: Hashable {
        let position: Vector
        let direction: Direction
    }

    let obstacles = map.obstacles
    var guardPosition = map.guardPosition
    var guardDirection: Direction = Direction.north

    var positionDirections: Set = [PositionDirectionCombo(position: guardPosition, direction: guardDirection)]
    while map.isInsideMap(guardPosition) {
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
        }

        let newPositionDirectionCombo = PositionDirectionCombo(position: guardPosition, direction: guardDirection)
        if positionDirections.contains(newPositionDirectionCombo) {
            return true
        } else {
            positionDirections.insert(PositionDirectionCombo(position: guardPosition, direction: guardDirection))
        }
    }

    return false
}

struct Map {
    let width: Int 
    let height: Int
    var obstacles: Set<Vector>
    let guardPosition: Vector

    func isInsideMap(_ coord: Vector) -> Bool {
        coord.x >= 0 && coord.x < width && coord.y >= 0 && coord.y < height
    }

    init(_ input: String) {
        let rows = input.split(separator: "\n").map(String.init)
        height = rows.count
        width = rows.first?.count ?? 0

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

        self.guardPosition = guardPosition
        self.obstacles = obstacles
    }
}
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
    getEscapePath(in: mapString).count
}

func getEscapePath(in mapString: String) -> Set<Vector> {
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

    return path.filter { map.isInsideMap($0) }
}

func numberOfPositionsForObstructions(in mapString: String) -> Int {
    var map = Map(mapString)
    let path = getEscapePath(in: mapString)
    print("Path length: \(path.count)")

    var obstaclePlaces: Set<Vector> = []
    
    var placesToCheck: Set<Vector> = []
    print("Build up places to check")
    for pathCoord in path {
        for y in -1 ... 1 {
            for x in -1 ... 1 {
                let possibleObstacleCoord = Vector(x: x, y: y) + pathCoord
                placesToCheck.insert(possibleObstacleCoord)
            }
        }
    }

    print("Done building places to check")
    print("Start putting obstacles in the path")
    for possibleObstacleCoord in placesToCheck {
        if map.isInsideMap(possibleObstacleCoord) && map.obstacles.contains(possibleObstacleCoord) == false {       
            map.obstacles.insert(possibleObstacleCoord)
            if guardIsTrappedInLoop(map: map) {
                obstaclePlaces.insert(possibleObstacleCoord)
            }
            map.obstacles.remove(possibleObstacleCoord)
        }
    }
    print("Done putting obstacles in the path")

    return obstaclePlaces.filter { map.isInsideMap($0) }.count
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
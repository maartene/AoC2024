import Shared

func numberOfDistinctVisitedPositions(in mapString: String) -> Int {
    let map = interpretMap(mapString)
    let obstacles = map.obstacles
    let guardPosition = map.guardPosition

    let obstaclesInLine = obstacles.filter { $0.x == guardPosition.x }

    if let obstaclePosition = obstaclesInLine.first?.y {
        return 1 + guardPosition.y - obstaclePosition - 1 
    } else {
        return guardPosition.y + 1
    } 
}

typealias Map = (obstacles: Set<Vector>, guardPosition: Vector)

func interpretMap(_ input: String) -> Map {
    let rows = input.split(separator: "\n").map(String.init)
    
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

    return (obstacles, guardPosition)
}
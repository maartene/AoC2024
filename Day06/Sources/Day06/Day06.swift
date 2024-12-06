import Shared

func numberOfDistinctVisitedPositions(in mapString: String) -> Int {
    let map = interpretMap(mapString)
    let obstacles = map.obstacles
    let guardPosition = map.guardPosition

    if let obstaclePosition = obstacles.first?.y {
        return 1 + guardPosition - obstaclePosition - 1 
    } else {
        return guardPosition + 1
    } 
}

typealias Map = (obstacles: Set<Vector>, guardPosition: Int)

func interpretMap(_ input: String) -> Map {
    let rows = input.split(separator: "\n").map(String.init)
    
    var obstacles = Set<Vector>() 
    for y in 0 ..< rows.count {
        let row = rows[y].map { $0 }
        for x in 0 ..< row.count {
            if row[x] == "#" {
                obstacles.insert(Vector(x: x, y: y))
            }
        }
    }

    let guardPosition = rows.firstIndex { $0.contains("^") }!

    return (obstacles, guardPosition)
}
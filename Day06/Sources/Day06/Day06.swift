import Shared

func numberOfDistinctVisitedPositions(in mapString: String) -> Int {
    let rows = mapString.split(separator: "\n").map(String.init)
    
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
    if let obstaclePosition = obstacles.first?.y {
        return 1 + guardPosition - obstaclePosition - 1 
    } else {
        return guardPosition + 1
    } 
}
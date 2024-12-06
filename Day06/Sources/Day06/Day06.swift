import Shared

func numberOfDistinctVisitedPositions(in mapString: String) -> Int {
    let map = interpretMap(mapString)
    let obstacles = map.obstacles
    var guardPosition = map.guardPosition

    var count = 0
    while guardPosition.y >= 0 && obstacles.contains(guardPosition) == false {
        guardPosition.y -= 1
        count += 1
    } 

    return count
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
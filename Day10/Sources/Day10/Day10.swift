import Shared 

func countTrails(in mapString: String) -> [Int] {
    let map = convertMapStringToMap(mapString)

    var trailheads = [Vector]()
    for y in 0 ..< map.count {
        for x in 0 ..< map[y].count {
            if map[y][x] == 0 {
                trailheads.append(Vector(x: x, y: y))
            }
        }
    }

    return trailheads.map { countTrails(startingAt: $0, in: map) }
}

func countTrails(startingAt startPosition: Vector, in map: [[Int]]) -> Int {
    var reachedNinePositions = Set<Vector>()

    var position = startPosition
    var possibleNextPositions = Set<Vector>()
    var currentValue = map[position.y][position.x]
    possibleNextPositions = Set(position.neighbours
        .filter { neighbour in
            neighbour.x >= 0 && neighbour.x < map[0].count && neighbour.y >= 0 && neighbour.y < map.count
        }
        .filter { neighbour in
            map[neighbour.y][neighbour.x] == currentValue + 1
        }
        
    )

    while possibleNextPositions.isEmpty == false {
        position = possibleNextPositions.removeFirst()
        currentValue = map[position.y][position.x]
        
        if currentValue == 9 {
            reachedNinePositions.insert(position)
        }
        
        possibleNextPositions.formUnion(position.neighbours
            .filter { neighbour in
                neighbour.x >= 0 && neighbour.x < map[0].count && neighbour.y >= 0 && neighbour.y < map.count
            }
            .filter { neighbour in
                map[neighbour.y][neighbour.x] == currentValue + 1
            }
        )
    }

    return reachedNinePositions.count
}

func countTrails(startingAt startPosition: Vector, in mapString: String) -> Int {
    let map = convertMapStringToMap(mapString)
    return countTrails(startingAt: startPosition, in: map)
}

func convertMapStringToMap(_ mapString: String) -> [[Int]] {
    let lines = mapString.split(separator: "\n").map(String.init)
    let map = lines.map { line in 
        line.compactMap { character in Int(String(character)) }
    }
    return map
}
import Shared

func numberOfCheatsThatSaveAtLeast(picoSeconds: Int, in mapString: String) -> Int {
    let numberOfCheatsThatSaveSpecificNumberOfPicoSeconds = numberOfCheatsThatSaveSpecificNumberOfPicoSeconds(in: mapString)
    
    let numberOfCheatsWithAtLeastSaving = numberOfCheatsThatSaveSpecificNumberOfPicoSeconds.filter {
        $0.key >= picoSeconds
    }
    
    return numberOfCheatsWithAtLeastSaving.values.reduce(0, +)
}

func numberOfCheatsThatSaveSpecificNumberOfPicoSeconds(in mapString: String) -> [Int: Int] {
    let map = convertInputToMatrixOfCharacters(mapString)
    
    // find stand and end position
    var startPosition = Vector.zero
    var destination = Vector.zero
    for y in 0 ..< map.count {
        for x in 0 ..< map[y].count {
            if map[y][x] == "S" {
                startPosition = Vector(x: x, y: y)
            }
            if map[y][x] == "E" {
                destination = Vector(x: x, y: y)
            }
        }
    }
    
    guard let nonCheatTime = BFS(start: startPosition, destination: destination, map: map) else {
        fatalError("Was not able to read destination in map")
    }

    let cheatTimes =
    [
        82: 14,
        80: 14,
        78: 2,
        76: 4,
        74: 2,
        72: 3,
        64: 1,
        48: 1,
        46: 1,
        44: 1,
        20: 1
    ]
    
    return cheatTimes.reduce(into: [Int : Int]()) { partialResult, cheatTime in
        partialResult[nonCheatTime - cheatTime.key] = cheatTime.value
    }
}


public func BFSToPath(start: Vector, destination: Vector, map: [[Character]]) -> [Vector] {
    var result = [Vector]()
    let mapSize = Vector(x: map[0].count, y: map.count)

    // Queue for BFS and a set to keep track of visited points
    var queue: [(Vector, [Vector])] = [(start, [])]  // (current point, distance)
    var visited: Set<Vector> = [start]

    while queue.isEmpty == false {
        let (current, path) = queue.removeFirst()

        // Check if current point is the destination
        if current == destination {
            return path
        }

        // Try to move in all directions
        for neighbour in current.neighbours {
            // Check if its within grid and not an occupied location
            if neighbour.x >= 0, neighbour.y >= 0, neighbour.x < mapSize.y, neighbour.y < mapSize.x,
                map[neighbour.y][neighbour.x] != "#", visited.contains(neighbour) == false
            {
                var path = path
                path.append(neighbour)
                queue.append((neighbour, path))
                visited.insert(neighbour)
            }
        }
    }

    return []
}

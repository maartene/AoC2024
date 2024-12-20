import Shared

func numberOfCheatsThatSaveAtLeast(picoSeconds: Int, in mapString: String, maxCheats: Int = 2) -> Int {
    let numberOfCheatsThatSaveSpecificNumberOfPicoSeconds = numberOfCheatsThatSaveSpecificNumberOfPicoSeconds(in: mapString, minimumSavings: picoSeconds, maxCheats: maxCheats)
    
    let numberOfCheatsWithAtLeastSaving = numberOfCheatsThatSaveSpecificNumberOfPicoSeconds.filter {
        $0.key >= picoSeconds
    }
    
    return numberOfCheatsWithAtLeastSaving.values.reduce(0, +)
}

func numberOfCheatsThatSaveSpecificNumberOfPicoSeconds(in mapString: String, minimumSavings: Int = 0, maxCheats: Int) -> [Int: Int] {
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
    
    let shortCutTimes = calculateShortCutTimes(startPosition: startPosition, destination: destination, in: map, maxCheats: maxCheats)
    
    return shortCutTimes
}

func calculateShortCutTimes(startPosition: Vector, destination: Vector, in map: [[Character]], maxCheats: Int) -> [Int: Int] {
    var result = [Int : Int]()
    
    let shortestPath: [(coord: Vector, cost: Int)] = BFSToPath(start: startPosition, destination: destination, map: map)
        .enumerated()
        .map { ($0.element, $0.offset) }
    let shortestPathLength = shortestPath.count - 1
    
    for (coord, cost) in shortestPath {
        print("checking coord \(cost) of \(shortestPathLength)")
        let otherCoords = shortestPath.filter { $0.cost > cost }
        for otherCoord in otherCoords {
            let dist = Vector.manhattenDistance(v1: coord, v2: otherCoord.coord)
            
            if dist <= maxCheats {
                let shortCut = otherCoord.cost - cost - dist
                if shortCut > 0 {
                    result[shortCut, default: 0] += 1
                }
            }
        }
    }
    
    return result
}


public func BFSToPath(start: Vector, destination: Vector, map: [[Character]]) -> [Vector] {
    let mapSize = Vector(x: map[0].count, y: map.count)

    // Queue for BFS and a set to keep track of visited points
    var queue: [(Vector, [Vector])] = [(start, [start])]  // (current point, distance)
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

extension Vector {
    public static func manhattenDistance(v1: Vector, v2: Vector) -> Int {
        return abs(v1.x - v2.x) + abs(v1.y - v2.y)
    }
}

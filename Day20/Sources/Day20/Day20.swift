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

    let cheatTimes = calculateCheatTimes(startPosition: startPosition, destination: destination, in: map, maxTime: nonCheatTime)
    
//    let cheatTimes =
//    [
//        82: 14,
//        80: 14,
//        78: 2,
//        76: 4,
//        74: 2,
//        72: 3,
//        64: 1,
//        48: 1,
//        46: 1,
//        44: 1,
//        20: 1
//    ]
    
    return cheatTimes.reduce(into: [Int : Int]()) { partialResult, cheatTime in
        partialResult[nonCheatTime - cheatTime.key] = cheatTime.value
    }
}

func calculateCheatTimes(startPosition: Vector, destination: Vector, in map: [[Character]], maxTime: Int) -> [Int: Int] {
    var cheatMap = map
    
    var result = [Int : Int]()
    
    let shortestPath = BFSToPath(start: startPosition, destination: destination, map: cheatMap)
    
    var paths = Set<[Vector]>()
    
    for position in shortestPath {
        let otherPositions = shortestPath.filter { $0 != position }
        
        for otherPosition in otherPositions {
            if Vector.manhattenDistance(v1: position, v2: otherPosition) == 2 {
                let intermediatePoint = position + ((otherPosition - position) / 2)
                if map[intermediatePoint.y][intermediatePoint.x] == "#" {
                    cheatMap[intermediatePoint.y][intermediatePoint.x] = "."
                    //if let count = BFS(start: startPosition, destination: destination, map: cheatMap) {
                    let path = BFSToPath(start: startPosition, destination: destination, map: cheatMap)
                    if path.count == 20 { print(path) }
                    if path.count < maxTime && paths.contains(path) == false {
                        result[path.count, default: 0] += 1
                        paths.insert(path)
                        }
                    //}
                    cheatMap[intermediatePoint.y][intermediatePoint.x] = "#"
                }
            }
        }
        
    }
    
    return result
}


public func BFSToPath(start: Vector, destination: Vector, map: [[Character]]) -> [Vector] {
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

extension Vector {
    public static func manhattenDistance(v1: Vector, v2: Vector) -> Int {
        return abs(v1.x - v2.x) + abs(v1.y - v2.y)
    }
}

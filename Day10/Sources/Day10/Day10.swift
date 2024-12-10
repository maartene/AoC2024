import Shared 

// MARK: Part 1
func sumOfTrailsCount(in mapString: String) -> Int {
    let trailsCounts = countTrails(in: mapString)
    return trailsCounts.reduce(0, +)
}

func countTrails(in mapString: String) -> [Int] {
    let map = convertMapStringToMap(mapString)
    let trailheads = extractTrailheads(in: map)   

    return trailheads.map { countTrails(startingAt: $0, in: map) }
}

func countTrails(startingAt startPosition: Vector, in map: [[Int]]) -> Int {
    Set(countDistinctHikingTrails(startingAt: startPosition, in: map)).count
}

func countTrails(startingAt startPosition: Vector, in mapString: String) -> Int {
    let map = convertMapStringToMap(mapString)
    return countTrails(startingAt: startPosition, in: map)
}

// MARK: Part 2
func sumOfDistinctTrailsCount(in mapString: String) -> Int {
    let trailsCounts = countDistinctHikingTrails(in: mapString)
    return trailsCounts.reduce(0, +)
}

func countDistinctHikingTrails(in mapString: String) -> [Int] {
    let map = convertMapStringToMap(mapString)
    let trailheads = extractTrailheads(in: map) 

    return trailheads.map { countDistinctHikingTrails(startingAt: $0, in: map).count }
}

// MARK: Generic
func countDistinctHikingTrails(startingAt startPosition: Vector, in map: [[Int]]) -> [Vector] {
    var reachedNinePositions = [Vector]()

    var position = startPosition
    var currentValue = map[position.y][position.x]
    var possibleNextPositions = getPossibleNextLocations(position: position, currentValue: currentValue, map: map)

    while possibleNextPositions.isEmpty == false {
        position = possibleNextPositions.removeFirst()
        currentValue = map[position.y][position.x]
        
        if currentValue == 9 {
            reachedNinePositions.append(position)
        }
        
        possibleNextPositions.append(contentsOf: getPossibleNextLocations(position: position, currentValue: currentValue, map: map))
    }

    return reachedNinePositions
}

func getPossibleNextLocations(position: Vector, currentValue: Int, map: [[Int]]) -> [Vector] {
    position.neighbours
        .filter { neighbour in
            neighbour.x >= 0 && neighbour.x < map[0].count && neighbour.y >= 0 && neighbour.y < map.count
        }
        .filter { neighbour in
            map[neighbour.y][neighbour.x] == currentValue + 1
        }
}

func convertMapStringToMap(_ mapString: String) -> [[Int]] {
    let lines = mapString.split(separator: "\n").map(String.init)
    let map = lines.map { line in 
        line.map { character in Int(String(character)) ?? 99 }
    }
    return map
}

func extractTrailheads(in map: [[Int]]) -> [Vector] {
    var trailheads = [Vector]()
    for y in 0 ..< map.count {
        for x in 0 ..< map[y].count {
            if map[y][x] == 0 {
                trailheads.append(Vector(x: x, y: y))
            }
        }
    }

    return trailheads
}
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

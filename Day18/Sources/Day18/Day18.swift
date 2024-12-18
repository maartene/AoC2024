import Shared

func shortestPath(through input: String, simulateUntilByte: Int = Int.max, mapSize: Vector) -> Int {
    let lines = input.split(separator: "\n").map { String($0)}
    let maxByte = min(simulateUntilByte, lines.count)
    let memory = lines
        .map { Vector(from: $0) }
        .enumerated()
        .filter { (offset, vector) in
            offset < maxByte
        } 
        .map { $0.element }
    
    return BFS(start: .zero, destination: mapSize - .one, unsafeSpots: Set(memory), mapSize: mapSize) ?? -1
}

func findFirstBlockingByte(input: String, startingAt: Int, mapSize: Vector) -> String {
    let lines = input.split(separator: "\n").map { String($0)}
    let entiryMemory = lines
        .map { Vector(from: $0) }

    var lower = startingAt
    var upper = lines.count 
    var simulateUntilByte = (lower + upper) / 2
    while lower < upper {
        simulateUntilByte = (lower + upper) / 2
        print("Testing until byte: \(simulateUntilByte) of \(lines.count)")
        let memory = entiryMemory.enumerated()
        .filter { (offset, vector) in
            offset < simulateUntilByte
        } 
        .map { $0.element }

        if BFS(start: .zero, destination: mapSize - .one, unsafeSpots: Set(memory), mapSize: mapSize) == nil {
            upper = simulateUntilByte
        } else {
            lower = simulateUntilByte + 1
        }
    }

    let coord = entiryMemory[lower - 1]
    return "\(coord.x),\(coord.y)"
}
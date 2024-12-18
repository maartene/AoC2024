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
    
    return BFS(start: .zero, destination: mapSize - .one, in: Set(memory), mapSize: mapSize) ?? -1
}

func BFS(start: Vector, destination: Vector, in memory: Set<Vector>, mapSize: Vector) -> Int? {
    // Queue for BFS and a set to keep track of visited points
    var queue: [(Vector, Int)] = [(start, 0)]  // (current point, distance)
    var visited: Set<Vector> = [start]

    while queue.isEmpty == false {
        let (current, distance) = queue.removeFirst()

        // Check if current point is the destination
        if current == destination {
            return distance
        }

        // Try to move in all directions
        for neighbour in current.neighbours {
            // Check if its within grid and not an occupied location
            if neighbour.x >= 0, neighbour.y >= 0, neighbour.x < mapSize.y, neighbour.y < mapSize.x,
               memory.contains(neighbour) == false, visited.contains(neighbour) == false {
                queue.append((neighbour, distance + 1))
                visited.insert(neighbour)
            }
        }
    }

    return nil
}

func findFirstBlockingByte(input: String, startingAt: Int, mapSize: Vector) -> String {
    let lines = input.split(separator: "\n").map { String($0)}
    let entiryMemory = lines
        .map { Vector(from: $0) }

    for simulateUntilByte in startingAt ..< lines.count {
        print("Testing until byte: \(simulateUntilByte) of \(lines.count)")
        let memory = entiryMemory.enumerated()
        .filter { (offset, vector) in
            offset < simulateUntilByte
        } 
        .map { $0.element }

        if BFS(start: .zero, destination: mapSize - .one, in: Set(memory), mapSize: mapSize) == nil {
            let coord = memory[simulateUntilByte - 1]
            return "\(coord.x),\(coord.y)"
        }
    }
    
    return ""
}
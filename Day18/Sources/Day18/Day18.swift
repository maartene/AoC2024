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
    let rowCount = mapSize.y
    let colCount = mapSize.x

    // Richtingen om noord, zuid, oost, west te bewegen
    let directions = [Vector(x: 0, y: 1), Vector(x: 1, y: 0), Vector(x: 0, y: -1), Vector(x: -1, y: 0)]

    // Queue voor BFS en een set om bezochte punten bij te houden
    var queue: [(Vector, Int)] = [(start, 0)]  // (huidige punt, afstand)
    var visited: Set<Vector> = [start]

    while queue.isEmpty == false {
        let (current, distance) = queue.removeFirst()

        // Check of het huidige punt de bestemming is
        if current == destination {
            return distance
        }

        // Probeer in alle richtingen te bewegen
        for direction in directions {
            let newX = current.x + direction.x
            let newY = current.y + direction.y
            let newPoint = Vector(x: newX, y: newY)

            // Controleer binnen de grid grenzen en of het punt niet bezocht is
            if newX >= 0, newY >= 0, newX < rowCount, newY < colCount,
               memory.contains(Vector(x: newX, y: newY)) == false, visited.contains(newPoint) == false {
                queue.append((newPoint, distance + 1))
                visited.insert(newPoint)
            }
        }
    }

    return nil
}

func printMap(memory: [Vector], mapSize: Vector) {
    for y in 0 ..< mapSize.y {
        var line = ""
        for x in 0 ..< mapSize.x {
            if memory.contains(Vector(x: x, y: y)) {
                line += "#"
            } else {
                line += "."
            }
        }
        print(line)
    }
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
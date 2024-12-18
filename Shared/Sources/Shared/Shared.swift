public func convertStringToIntMatrix(_ input: String) -> [[Int]] {
    let lines = input.split(separator: "\n").map(String.init)

    let matrix = lines.map { line in
        line.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
    }

    return matrix
}

public func convertInputToMatrixOfCharacters(_ input: String) -> [[Character]] {
    let lines = input.split(separator: "\n").map(String.init)
    
    let characters: [[Character]] = lines.map { line in
        line.map { $0 } 
    }
    
    return characters
}

public func memoize<In: Hashable, Out>(_ f: @escaping (In) -> Out) -> (In) -> Out {
    var memo: [In: Out] = [:]
    return {
        if let result = memo[$0] {
            return result
        } else {
            let result = f($0)
            memo[$0] = result
            return result
        }
    }
}

extension Vector {
    public init(from string: String) {
        let numbers = string.matches(of: /-*\d+/)
            .map { String($0.0) }
            .map { Int($0)! }

        x = numbers[0]
        y = numbers[1]
    }
}

public func BFS(start: Vector, destination: Vector, unsafeSpots: Set<Vector>, mapSize: Vector) -> Int? {
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
               unsafeSpots.contains(neighbour) == false, visited.contains(neighbour) == false {
                queue.append((neighbour, distance + 1))
                visited.insert(neighbour)
            }
        }
    }

    return nil
}
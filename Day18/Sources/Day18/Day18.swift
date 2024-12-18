import Shared

func shortestPath(through input: String, simulateUntilByte: Int = Int.max, mapSize: Vector) -> Int {
    let lines = input.split(separator: "\n").map { String($0)}
    let maxByte = min(simulateUntilByte, lines.count)
    let memory = lines
        .compactMap { Vector(from: $0) }
        .enumerated()
        .filter { (offset, vector) in
            offset < maxByte
        } 
        .map { $0.element }
    
    print(memory.count)

    let dijkstraMap = dijkstra(target: mapSize - .one, in: memory, mapSize: mapSize)

    return dijkstraMap[.zero] ?? -1
}

// MARK: Pathfinding
func enterable(from: Vector, to: Vector, in memory: [Vector]) -> Bool {
    memory.contains(to) == false
}

func getNeighboursFor(_ node: Vector, memory: [Vector], mapSize: Vector) -> [Vector] {
    node.neighbours
        .filter { $0.x >= 0 && $0.x < mapSize.x && $0.y >= 0 && $0.y <= mapSize.y }
        .filter { enterable(from: $0, to: node, in: memory) }
}

func cost(from: Vector, to: Vector) -> Int {
    1
}

func dijkstra(target: Vector, in memory: [Vector], mapSize: Vector) -> [Vector: Int] {
    var unvisited = Set<Vector>()
    var visited = Set<Vector>()
    var dist = [Vector: Int]()

    unvisited.insert(target)
    dist[target] = 0
    var currentNode = target
    while unvisited.isEmpty == false {
        let neighbours = getNeighboursFor(currentNode, memory: memory, mapSize: mapSize)
        for neighbour in neighbours {
            if visited.contains(neighbour) == false {
                unvisited.insert(neighbour)
            }
            let alt = dist[currentNode]! + cost(from: currentNode, to: neighbour)
            if alt < dist[neighbour, default: Int.max] {
                dist[neighbour] = alt
            }
        }

        unvisited.remove(currentNode)
        visited.insert(currentNode)

        if let newNode = unvisited.min(by: { dist[$0, default: Int.max] < dist[$1, default: Int.max] }) {
            currentNode = newNode
        }
    }

    return dist
}
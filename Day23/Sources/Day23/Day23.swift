// The Swift Programming Language
// https://docs.swift.org/swift-book

func numberOfSetsOfThreeInterconnectedComputersWithAT(_ input: String) -> Int {
    let connections = extractConnectionsFrom(input)
    
    var setsOfThreeInterconnectedComputers = Set<Set<String>>()
    
    let connectionsWithT = connections.filter { $0.key.contains("t") }
    
    for connectionWithT in connectionsWithT {
        for connectedComputer1 in connectionWithT.value {
            let connectedWithComputer1 = connections[connectedComputer1, default: []]
            for connectedComputer2 in connectedWithComputer1 {
                let connectedWithComputer2 = connections[connectedComputer2, default: []]
                var interconnectedComputers = Set<String>()
                interconnectedComputers.insert(connectionWithT.key)
                interconnectedComputers.insert(connectedComputer1)
                if connectedWithComputer2.contains(connectionWithT.key) {
                    interconnectedComputers.insert(connectedComputer2)
                }
                if interconnectedComputers.count == 3 {
                    setsOfThreeInterconnectedComputers.insert(interconnectedComputers)
                }
            }
        }
    }
        
    return setsOfThreeInterconnectedComputers
        .filter { $0.contains(where: { $0.contains("t") }) }
        .count
}

private func extractConnectionsFrom(_ input: String) -> [String: Set<String>] {
    let lines = input.split(separator: "\n")
    
    var connections = [String: Set<String>]()
    for line in lines {
        let connectionSplit = line.split(separator: "-").map { String($0) }
        
        let from = connectionSplit[0]
        let existingFrom = Set(connections[from] ?? [])
        let to = connectionSplit[1]
        connections[from] = existingFrom.union([to])
        
        let existingTo = connections[to] ?? []
        connections[to] = existingTo.union([from])
    }
    
    print(connections.count)
    
    return connections
}

// The Swift Programming Language
// https://docs.swift.org/swift-book

func numberOfSetsOfThreeInterconnectedComputersWithAT(_ input: String) -> Int {
    let connections = extractConnectionsFrom(input)
    
    var setsOfThreeInterconnectedComputers = Set<Set<String>>()
    
    let connectionsWithT = connections.filter { $0.key.starts(with: "t") }
    
    for connectionWithT in connectionsWithT {
        for connectedComputer1 in connectionWithT.value {
            let connectedWithComputer1 = connections[connectedComputer1, default: []]
            for connectedComputer2 in connectedWithComputer1 {
                let connectedWithComputer2 = connections[connectedComputer2, default: []]
                var interconnectedComputers = Set([connectionWithT.key, connectedComputer1])
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
        .count
}

private func extractConnectionsFrom(_ input: String) -> [String: Set<String>] {
    let lines = input.split(separator: "\n")
    
    var connections = [String: Set<String>]()
    for line in lines {
        let connectionSplit = line.split(separator: "-").map { String($0) }
        
        let from = connectionSplit[0]
        let to = connectionSplit[1]
        
        let existingFrom = connections[from, default: []]
        connections[from] = existingFrom.union([to])
        
        let existingTo = connections[to, default: []]
        connections[to] = existingTo.union([from])
    }
    
    return connections
}

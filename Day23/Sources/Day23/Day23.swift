// The Swift Programming Language
// https://docs.swift.org/swift-book

func numberOfSetsOfThreeInterconnectedComputersWithAT(_ input: String) -> Int {
    let connections = extractConnectionsFrom(input)
    
    let connectionsWithT = connections.filter { $0.key.starts(with: "t") }
    
    let setsOfThreeInterconnectedComputers = setsOfThreeInterconnectedComputers(searchSet: connectionsWithT, connections: connections)
        
    return setsOfThreeInterconnectedComputers
        .count
}

func password(for input: String) -> String {
    let connections = extractConnectionsFrom(input)

    var checkSet = setsOfThreeInterconnectedComputers(searchSet: connections, connections: connections)
    var checkNumber = 3

    while checkSet.count > 1 {
        print("We're at check number \(checkNumber), checkset is \(checkSet.count)")
        let previousSet = checkSet
        checkSet.removeAll()
        
        for set in previousSet {
            let nodesInSet = Array(set)
            var newNodes = connections[nodesInSet[0]] ?? []
            for i in 0 ..< checkNumber {
                newNodes.formIntersection(connections[nodesInSet[i]] ?? [])
            }
            for node in newNodes {
                checkSet.insert(set.union([node]))
            }
        }
            
        checkNumber += 1
    }
    
    guard let resultSet = checkSet.first else {
        return "unknown"
    }
    
    return(resultSet.sorted().joined(separator: ","))
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

private func setsOfThreeInterconnectedComputers(searchSet: [String : Set<String>], connections: [String: Set<String>]) -> Set<Set<String>> {
    var setsOfThreeInterconnectedComputers = Set<Set<String>>()
    for connectionWithT in searchSet {
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
}



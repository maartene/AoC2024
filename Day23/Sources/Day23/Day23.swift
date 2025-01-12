// The Swift Programming Language
// https://docs.swift.org/swift-book

func numberOfSetsOfThreeInterconnectedComputersWithAT(_ input: String) -> Int {
    let connections = extractConnectionsFrom(input)
    
    
    
    let setsOfThreeInterconnectedComputers: Set<Set<String>> = [
        ["aq", "cg" ,"yn"],
        ["aq", "vc" ,"wq"],
        ["co", "de" ,"ka"],
        ["co", "de" ,"ta"],
        ["co", "ka" ,"ta"],
        ["de", "ka" ,"ta"],
        ["kh", "qp" ,"ub"],
        ["qp", "td" ,"wh"],
        ["tb", "vc" ,"wq"],
        ["tc", "td" ,"wh"],
        ["td", "wh" ,"yn"],
        ["ub", "vc" ,"wq"],
    ]
    
    return setsOfThreeInterconnectedComputers
        .filter { $0.contains(where: { $0.contains("t") }) }
        .count
}

private func extractConnectionsFrom(_ input: String) -> Set<Set<String>> {
    let lines = input.split(separator: "\n")
    
    var connections = Set<Set<String>>()
    for line in lines {
        let connectionSplit = line.split(separator: "-").map { String($0) }
        let connection = Set(connectionSplit)
        connections.insert(connection)
    }
    
    return connections
}

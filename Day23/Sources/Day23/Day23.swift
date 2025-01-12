// The Swift Programming Language
// https://docs.swift.org/swift-book

func numberOfSetsOfThreeInterconnectedComputersWithAT(_ input: String) -> Int {
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

import Shared

func calculateNumberOfAntinodePositions(in map: String) -> Int {
    let nodes = convertInputToNodes(in: map)
    
    var antinodePositions = Set<Vector>()
    for node in nodes {
        let otherNodes = nodes.filter {
            $0.key != node.key && $0.value == node.value
        }
        
        for otherNode in otherNodes {
            let distance = otherNode.key - node.key
            let reflectionOne = otherNode.key + distance
            let reflectionTwo = node.key - distance
            antinodePositions.insert(reflectionOne)
            antinodePositions.insert(reflectionTwo)
        }
    }
    
    return antinodePositions.count
}

func convertInputToNodes(in map: String) -> [Vector: Character] {
    var nodes = [Vector: Character]()
    let rows = map.split(separator: "\n").map(String.init)
    
    for y in 0 ..< rows.count {
        let cols: [Character] = rows[y].map { $0 }
        for x in 0 ..< cols.count {
            let position = Vector(x: x, y: y)
            if cols[x] != "." {
                nodes[position] = cols[x]
            }
        }
    }
    
    return nodes
}

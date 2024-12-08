import Shared

func calculateNumberOfAntinodePositions(in map: String) -> Int {
    let map = Map(map)
    let nodes = map.nodes
    
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

struct Map {
    let nodes: [Vector: Character]
    let width: Int
    let height: Int
    
    init(_ mapString: String) {
        var nodes = [Vector: Character]()
        let rows = mapString.split(separator: "\n").map(String.init)
        
        height = rows.count
        width = rows.first?.count ?? 0
        
        for y in 0 ..< height {
            let cols: [Character] = rows[y].map { $0 }
            for x in 0 ..< width {
                let position = Vector(x: x, y: y)
                if cols[x] != "." {
                    nodes[position] = cols[x]
                }
            }
        }
        
        self.nodes = nodes
    }
}

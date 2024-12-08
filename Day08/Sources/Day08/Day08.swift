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
            let reflections = [otherNode.key + distance, node.key - distance]
            antinodePositions.formUnion(reflections)
        }
    }
    
    return antinodePositions
        .filter { map.isWithinBounds($0) }
        .count
}

func calculateNumberOfAntinodePositions_includingLines(in map: String) -> Int {
    let map = Map(map)
    let nodes = map.nodes
    
    var antinodePositions = Set<Vector>()
    for node in nodes {
        let otherNodes = nodes.filter {
            $0.key != node.key && $0.value == node.value
        }
        
        for otherNode in otherNodes {
            let reflections = findReflections(node: node.key, otherNode: otherNode.key, in: map)
            antinodePositions.formUnion(reflections)
        }
    }
    
    return antinodePositions.count
    
    func findReflections(node: Vector, otherNode: Vector, in map: Map) -> Set<Vector> {
        let distance = otherNode - node
        var reflections: Set = [node, otherNode]
        
        var testCoord = otherNode + distance
        while map.isWithinBounds(testCoord) {
            reflections.insert(testCoord)
            testCoord += distance
        }
        
        testCoord = node - distance
        while map.isWithinBounds(testCoord) {
            reflections.insert(testCoord)
            testCoord -= distance
        }
        
        return reflections
    }
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
    
    func isWithinBounds(_ position: Vector) -> Bool {
        position.x >= 0 && position.x < width && position.y >= 0 && position.y < height
    }
}

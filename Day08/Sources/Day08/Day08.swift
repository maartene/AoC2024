import Shared

func calculateNumberOfAntinodePositions(in map: String) -> Int {
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
    
    return nodes.count
}

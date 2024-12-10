import Shared 

func countTrails(startingAt startPosition: Vector, in mapString: String) -> Int {
    let lines = mapString.split(separator: "\n").map(String.init)
    let map = lines.map { line in 
        line.compactMap { character in Int(String(character)) }
    }

    let nineCount = map.flatMap { $0 }
        .filter { $0 == 9 }
        .count

    return nineCount
}
import Shared

func sumOfAllBoxesApplying(_ input: String) -> Int {
    let matrix = convertInputToMatrixOfCharacters(input)
    
    var obstacles = Set<Vector>()
    for y in 0 ..< matrix.count {
        for x in 0 ..< matrix[y].count {
            if matrix[y][x] == "O" {
                obstacles.insert(Vector(x: x, y: y))
            }
        }
    }
    
    let coordinates = obstacles.map { $0.x + 100 * $0.y }
    
    return coordinates.reduce(0, +)
}

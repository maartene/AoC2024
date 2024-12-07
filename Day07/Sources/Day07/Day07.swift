func equationCanBeMadeTrue(_ equation: String) -> Bool {
    let split = equation.split(separator: ":").map(String.init)
    let expectedNumber = Int(split[0])
    
    let numbersToPlayAroundWith = split[1].split(separator: " ").map(String.init).compactMap(Int.init)
    
    return numbersToPlayAroundWith[0] * numbersToPlayAroundWith[1] == expectedNumber
}

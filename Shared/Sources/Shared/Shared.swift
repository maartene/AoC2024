public func convertStringToIntMatrix(_ input: String) -> [[Int]] {
    let lines = input.split(separator: "\n").map(String.init)

    let matrix = lines.map { line in
        line.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
    }

    return matrix
}

public func convertInputToMatrixOfCharacters(_ input: String) -> [[Character]] {
    let lines = input.split(separator: "\n").map(String.init)
    
    let characters: [[Character]] = lines.map { line in
        line.map { $0 } 
    }
    
    return characters
}
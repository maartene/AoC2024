import Shared

func countXMAS(in input: String) -> Int {
    let directions = 
    [
        (1, 0), (-1, 0),                    // Horizontal 
        (0, 1), (0, -1),                    // Vertical
        (-1, -1), (1, -1), (-1, 1), (1, 1)  // Diagonal
    ]

    let characters = convertInputToMatrixOfCharacters(input)
    
    var count = 0

    for y in 0 ..< characters.count {
        for x in 0 ..< characters[y].count {
            for direction: (dx: Int, dy: Int) in directions {
                if checkForWordInCharacterMatrix(searchWord: "XMAS", characterMatrix: characters, position: (x, y), direction: direction) {
                    count += 1
                }
            }
        }
    }

    return count
}

func countX_MASses(in input: String) -> Int {
    let characters = convertInputToMatrixOfCharacters(input)
    
    var count = 0

    for y in 0 ..< characters.count {
        for x in 0 ..< characters[y].count {
            if  getCharacter(in: characters, at: (x, y)) == "A",
                let ul = getCharacter(in: characters, at: (x-1, y-1)),  
                let ur = getCharacter(in: characters, at: (x+1, y-1)), 
                let bl = getCharacter(in: characters, at: (x-1, y+1)),
                let br = getCharacter(in: characters, at: (x+1, y+1))
            {
                if  (ul == "M" && ur == "M" && bl == "S" && br == "S") ||
                    (ul == "M" && ur == "S" && bl == "M" && br == "S") ||
                    (ul == "S" && ur == "M" && bl == "S" && br == "M") ||
                    (ul == "S" && ur == "S" && bl == "M" && br == "M")
                 {
                    count += 1
                }
            }
        }
    }

    return count
}

func checkForWordInCharacterMatrix(searchWord: String, characterMatrix: [[Character]], position: (x: Int, y: Int), direction: (dx: Int, dy: Int)) -> Bool {
    var word = ""
    for i in 0 ..< searchWord.count {
        if let character = getCharacter(in: characterMatrix, at: (position.x + direction.dx * i, position.y + direction.dy * i)) {
            word += String(character)
        }
    }

    return word == searchWord
}

func getCharacter(in array: [[Character]], at coord: (x: Int, y: Int)) -> Character? {
    guard coord.x >= 0 && coord.x < array[0].count && coord.y >= 0 && coord.y < array.count else {
        return nil
    }

    return array[coord.y][coord.x]
}
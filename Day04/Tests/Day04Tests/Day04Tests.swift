import Testing
@testable import Day04

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

func convertInputToMatrixOfCharacters(_ input: String) -> [[Character]] {
    let lines = input.split(separator: "\n").map(String.init)
    let characters: [[Character]] = lines.map { line in
        line.map { $0 } 
    }
    return characters
}

func checkForWordInCharacterMatrix(searchWord: String, characterMatrix: [[Character]], position: (x: Int, y: Int), direction: (dx: Int, dy: Int)) -> Bool {
    func getCharacter(in array: [[Character]], at coord: (x: Int, y: Int)) -> Character? {
        guard coord.x >= 0 && coord.x < array[0].count && coord.y >= 0 && coord.y < array.count else {
            return nil
        }

        return array[coord.y][coord.x]
    }

    var word = ""
    for i in 0 ..< searchWord.count {
        if let character = getCharacter(in: characterMatrix, at: (position.x + direction.dx * i, position.y + direction.dy * i)) {
            word += String(character)
        }
    }

    return word == searchWord
}

@Suite("To find the first star on day 04") struct Day04StarOneTests {
    @Test("The word XMAS should appear 0 times in an empty input") func emptyArrayCase() {
        #expect(countXMAS(in: "") == 0)
    }

    @Test("The word XMAS appears in these single line strings L->R only once", arguments: [
        "XMAS",
        "FOOBXMASAR",
        "XMASBAZ",
        "HELOOXMAS"
    ]) func xmasAppearsOnlyOnce(testcase: String) {
        #expect(countXMAS(in: testcase) == 1)
    }

    @Test("The word XMAS appears in these single line strings L->R more than once", arguments: [
        ("XMASXMAS", 2),
        ("FOOXMASBARXMASBAZ", 2),
        ("FOOXMASBARXMASBAZFOOXMASBARXMASBAZ", 4)
    ]) func xmasAppearsMultipleTimes(testcase: (input: String, expected: Int)) {
        #expect(countXMAS(in: testcase.input) == testcase.expected)
    }

    @Test("This is not XMAS") func twoLineBreakXMAS() {
        let input =
        """
        AAX
        MAS
        """

        #expect(countXMAS(in: input) == 0)
    }

    @Test("Find the word christmas in a two line input as well") func twoLineInput() {
        let input = 
        """
        XMASXMASAAAAAAAAAAAAAAAAAAAAAAAAAA
        FOOXMASBARXMASBAZAAAAAAAAAAAAAAAAA
        FOOXMASBARXMASBAZFOOXMASBARXMASBAZ
        """
        #expect(countXMAS(in: input) == 8)
    }

    @Test("Find the word christmas vertically as well") func verticalXMAS() {
        let input = 
        """
        AXE
        BMF
        CAG
        DSH
        """
        
        #expect(countXMAS(in: input) == 1)
    }

    @Test("We should find the word XMAS in the example input 18 times") func countInExampleInput() {
        let exampleInput = 
        """
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
        """

        #expect(countXMAS(in: exampleInput) == 18)
    }
}

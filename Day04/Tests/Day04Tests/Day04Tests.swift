import Testing
@testable import Day04

func countXMAS(in input: String) -> Int {
    func getCharacter(in array: [[Character]], at coord: (x: Int, y: Int)) -> Character? {
        guard coord.x >= 0 && coord.x < array[0].count && coord.y >= 0 && coord.y < array.count else {
            return nil
        }

        return array[coord.y][coord.x]
    }

    let lines = input.split(separator: "\n").map(String.init)
    let characters: [[Character]] = lines.map { line in
        line.map { $0 } 
    }

    var count = 0

    for y in 0 ..< characters.count {
        for x in 0 ..< characters[y].count {
            var word = ""
            for i in 0 ..< 4 {
                if let character = getCharacter(in: characters, at: (x + i, y)) {
                    word += String(character)
                }
            }
            if word == "XMAS" {
                count += 1
            }

                // search N -> S
            if  let l1 = getCharacter(in: characters, at: (x, y)),
                let l2 = getCharacter(in: characters, at: (x, y + 1)),
                let l3 = getCharacter(in: characters, at: (x, y + 2)),
                let l4 = getCharacter(in: characters, at: (x, y + 3)),
                l1 == "X", l2 == "M", l3 == "A", l4 == "S" {
                    count += 1
                } 
        }
    }

    return count
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
}

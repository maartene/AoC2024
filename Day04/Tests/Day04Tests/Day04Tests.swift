import Testing
@testable import Day04

func countXMAS(in input: String) -> Int {
    let characters: [Character] = input.map { $0 }

    guard characters.count >= 4 else {
        return 0
    }

    for i in 0 ..< characters.count - 3 {
        if characters[i] == "X" &&
            characters[i + 1] == "M" && 
            characters[i + 2] == "A" &&
            characters[i + 3] == "S" {
            return 1
         }
    }

    return 0
}

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To find the first star on day 04") struct Day04StarOneTests {
    @Test("The word XMAS should appear 0 times in an empty input") func emptyArrayCase() {
        #expect(countXMAS(in: "") == 0)
    }

    @Test("The word XMAS should appear once times in the string 'XMAS'") func actualSearchStringCase() {
        #expect(countXMAS(in: "XMAS") == 1)
    }

    @Test("The word XMAS should appear once times in the string 'XMAS'") func inTheMiddleOfStringCase() {
        #expect(countXMAS(in: "FOOBXMASAR") == 1)
    }
}

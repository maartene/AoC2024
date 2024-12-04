import Testing
import Shared
@testable import Day04

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

    @Test("The count of XMAS in the actual input should be 2507") func countInActualInput() {
        #expect(countXMAS(in: input) == 2507)
    }

}

@Suite("To find the second star on day 04") struct Day04StarTwoTests {
    @Test("We should find one X-MAS in the minimal case") func minimalX_Mas() {
        let input = 
        """
        M.S
        .A.
        M.S
        """

        #expect(countX_MASses(in: input) == 1)
    }

    @Test("We should find two X-MAS in the minimal case") func two_MinimalX_Mas() {
        let input = 
        """
        M.S.M.S
        .A...A.
        M.S.M.S
        """

        #expect(countX_MASses(in: input) == 2)
    }

    @Test("We should find two X-MASses in the example input 9 times") func countInExampleInput() {
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

        #expect(countX_MASses(in: exampleInput) == 9)
    }

    @Test("The count of X-MASses in the actual input should be 1969") func countInActualInput() {
        #expect(countX_MASses(in: input) == 1969)
    }
}

import Testing
@testable import Day11

@Suite("To get the first star on day 11") struct Day11StarOneTests {
    @Test("After blinking, a single stones should be have changed in the following manners", arguments: [
        ("0", "1"),             // rule 1
        ("1234", "12 34"),      // rule 2
        ("1000", "10 0"),       // rule 2 - edge case
        ("123", "248952")       // rule 3
    ]) func testIndividualrulesOnSingleStone(testcase: (initialStoneArrangement: String, expectedStoneArrangement: String)) {
        #expect(blink(testcase.initialStoneArrangement) == testcase.expectedStoneArrangement)
    }

    @Test("Blink two stones") func blinkTwoStones() {
        #expect(blink("0 1") == "1 2024")
    }

    @Test("After blinking once, the stones in the first example should be ararnged as '1 2024 1 0 9 9 2021976'") func blinkOnce_withFirstExampleInput() {
        let firstExampleInput = "0 1 10 99 999"
        #expect(blink(firstExampleInput) == "1 2024 1 0 9 9 2021976")
    }

    @Test("After blinking two times with initial arrangement '125 17' the arrangement should be '253 0 2024 14168'") func blinkTwice_withSecondExampleInput() {
        let secondExampleInput = "125 17"
        #expect(blink("125 17", count: 2) == "253 0 2024 14168")
    }
}
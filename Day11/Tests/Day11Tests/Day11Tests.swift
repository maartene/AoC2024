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
        let exampleInput = "0 1 10 99 999"
        #expect(blink(exampleInput) == "1 2024 1 0 9 9 2021976")
    }
}
import Testing
@testable import Day11

@Suite("To get the first star on day 11") struct Day11StarOneTests {
    @Test("After blinking, a single stones should be have changed in the following manners", arguments: [
        ("0", "1")
    ]) func testIndividualrulesOnSingleStone(testcase: (initialStoneArrangement: String, expectedStoneArrangement: String)) {
        #expect(blink(testcase.initialStoneArrangement) == testcase.expectedStoneArrangement)
    }

    // First acceptance test
    // @Test("After blinking once, the stones in the example input should be ararnged as '1 2024 1 0 9 9 2021976'") func blinkOnce_withExampleInput() {
    //     let exampleInput = "0 1 10 99 999"
    //     #expect(blink(exampleInput) == "")
    // }
}
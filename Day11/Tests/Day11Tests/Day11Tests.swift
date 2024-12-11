import Testing
@testable import Day11

@Suite("To get the first star on day 11") struct Day11StarOneTests {
    let stoneCounter = StoneCounter()

    @Test("After blinking, a single stones should be have changed in the following manners", arguments: [
        ("0", "1"),             // rule 1
        ("1234", "12 34"),      // rule 2
        ("1000", "10 0"),       // rule 2 - edge case
        ("123", "248952")       // rule 3
    ]) func testIndividualrulesOnSingleStone(testcase: (initialStoneArrangement: String, expectedStoneArrangement: String)) {
        #expect(stoneCounter.blink(testcase.initialStoneArrangement) == testcase.expectedStoneArrangement)
    }

    @Test("Blink two stones") func blinkTwoStones() {
        #expect(stoneCounter.blink("0 1") == "1 2024")
    }

    @Test("After blinking once, the stones in the first example should be ararnged as '1 2024 1 0 9 9 2021976'") func blinkOnce_withFirstExampleInput() {
        let firstExampleInput = "0 1 10 99 999"
        #expect(stoneCounter.blink(firstExampleInput) == "1 2024 1 0 9 9 2021976")
    }

    let secondExampleInput = "125 17"

    @Test("After blinking two times with initial arrangement '125 17' the arrangement should be '253 0 2024 14168'") func blinkTwice_withSecondExampleInput() {
        #expect(stoneCounter.blink(secondExampleInput, count: 2) == "253 0 2024 14168")
    }

    @Test("After blinking 6 times with initial arrangement '125 17' the arrangement should be '2097446912 14168 4048 2 0 2 4 40 48 2024 40 48 80 96 2 8 6 7 6 0 3 2'") func blinkSixTimes_withSecondExampleInput() {
        #expect(stoneCounter.blink(secondExampleInput, count: 6) == "2097446912 14168 4048 2 0 2 4 40 48 2024 40 48 80 96 2 8 6 7 6 0 3 2")
    }

    @Test("After blinking N times with initial arrangement '125 17' the number of stones should be'", arguments: [
        (6, 22),
        (25, 55312)
    ]) func numberOfStonesWhenCountingNTimes_withSecondExampleInput(testcase: (blinkCount: Int, expectedStoneCount: Int)) {
        #expect(stoneCounter.numberOfStonesAfterBlinking(stoneArrangement: secondExampleInput, count: testcase.blinkCount) == testcase.expectedStoneCount)
    }

    @Test("After blinking 25 times with the actual input, the number of stones should be 186996") func numberOfStonesWhenCountingNTimes_withActualInput() {
        #expect(stoneCounter.numberOfStonesAfterBlinking(stoneArrangement: input, count: 25) == 186996)
    }
}

@Suite("To get the second star on day 11") struct Day11StarTwoTests {
    let stoneCounter = StoneCounter()
    @Test("After blinking 75 times with the actual input, the number of stones should be 221683913164898") func numberOfStonesWhenCountingNTimes_withActualInput() {
        #expect(stoneCounter.numberOfStonesAfterBlinking(stoneArrangement: input, count: 75) == 221683913164898)
    }
}
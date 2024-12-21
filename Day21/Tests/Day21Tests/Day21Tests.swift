import Testing
@testable import Day21

let exampleInput =
    """
    029A
    980A
    179A
    456A
    379A
    """

@Suite("To get the first star on day 21") struct Day21StarOneTests {
    @Test("The complexity factor of the example input is 126384") func complexityFactorOfExampleInput() {
        #expect(complexityFactor(of: exampleInput) == 126384)
    }
    
    @Test("The complexity factor of the actual input is 162740") func complexityFactorOfActualInput() {
        #expect(complexityFactor(of: input) == 162740)
    }
}

//@Suite("To get the second star on day 21") struct Day21StarTwoTests {
//    @Test("The complexity factor of the example input is 126384") func complexityFactorOfExampleInput() {
//        #expect(complexityFactor(of: exampleInput) == 126384)
//    }
//}


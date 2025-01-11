import Shared
import Testing

@testable import Day22

@Suite("To get the first star on day 22") struct Day22StarOneTests {
    let exampleInput =
        """
        1
        10
        100
        2024
        """

    @Test("The sum of secret numbers after 2000 passes for the example input should be 37327623")
    func sumOfSecretNumbers_forExampleInput() {
        #expect(sumOfSecretNumbers(for: exampleInput) == 37_327_623)
    }

    @Test("Calculate a next secret numbers") func nextSecretNumbers() {
        #expect(calculateNextSecretNumber(seed: 123) == 15_887_950)
    }

    @Test("The sum of secret numbers after 2000 passes for the actual input should be 14273043166")
    func sumOfSecretNumbers_forActualInput() {
        #expect(sumOfSecretNumbers(for: input) == 14_273_043_166)
    }
}

@Suite("To get the second star on day 22") struct Day22StarTwoTests {
    let exampleInput =
        """
        1
        2
        3
        2024
        """

    @Test("The maximum number of bananas you can get paid for the example input should be 23")
    func maximumNumberOfBananas_forExampleInput() {
        #expect(maximumNumberOfBananas(for: exampleInput) == 23)
    }
    
//    @Test("The maximum number of bananas you can get paid for the actual input should be 1667")
//    func maximumNumberOfBananas_forActualInput() {
//        #expect(maximumNumberOfBananas(for: input) == 1667)
//    }
}

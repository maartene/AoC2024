import Foundation
import Testing
@testable import Day03

func calculateSumOfMultiplications(_ input: String) -> Int {
    let multiplications = extractMultiplications(input)
    let multiplicationResults = multiplications.map(performMultiplication)
    return multiplicationResults.reduce(0, +)
}

func extractMultiplications(_ input: String) -> [String] {
    let regex: Regex = /(mul\([0-9]+,[0-9]+\))/
    let result = input.matches(of: regex)
        .map { String($0.0) }
    return result
}

func performMultiplication(_ input: String) -> Int {
    let regex = /[0-9]+/
    let result = input.matches(of: regex).map { String($0.0) }
        .compactMap(Int.init)
    return result[0] * result[1]
}

let exampleInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

@Suite("To get the first star on day 03") struct Day03Star1Tests {
    @Test("we should be able to extract correct multiplication statements from input") func acceptanceTest_extractCorrectMultiplicationsFromInput() {
        let expected = [
            "mul(2,4)",
            "mul(5,5)",
            "mul(11,8)",
            "mul(8,5)"
        ]

        #expect(extractMultiplications(exampleInput) == expected)
    }

    @Test("we should be able to perform a multiplication statement", arguments: 
        [
            ("mul(2,4)", 8),
            ("mul(5,5)", 25),
            ("mul(11,8)", 88),
            ("mul(8,5)", 40)
        ]) func performingMultiplication(testcase: (input: String, expected: Int)) {
        #expect(performMultiplication(testcase.input) == testcase.expected)
    }

    @Test("calculating the sum of all multiplications should return 161 for the example input") func calculatingTheSumOfMultiplications_forExampleInput() {
        #expect(calculateSumOfMultiplications(exampleInput) == 161)
    }

    @Test("the sum of all multiplications in the actual input should be 164730528") func sumOfMultiplications_forActualInput() {
        #expect(calculateSumOfMultiplications(input) == 164730528)
    }
}
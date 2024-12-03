import Foundation
import Testing
@testable import Day03

func extractMultiplications(_ input: String) -> [String] {
    let regex: Regex = /(mul\([0-9]+,[0-9]+\))/
    let result = input.matches(of: regex)
        .map { String($0.0) }
    print(result)
    return result
}

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 03") struct Day03Star1Tests {
    @Test("we should be able to extract correct multiplication statements from input") func acceptanceTest_extractCorrectMultiplicationsFromInput() {
        let exampleInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
        let expected = [
            "mul(2,4)",
            "mul(5,5)",
            "mul(11,8)",
            "mul(8,5)"
        ]

        #expect(extractMultiplications(exampleInput) == expected)
    }
}
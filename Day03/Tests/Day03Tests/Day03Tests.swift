import Testing
@testable import Day03

func extractMultiplicationsIncludingDosAndDonts(_ input: String) -> [String] {
    let regex: Regex = /(mul\([0-9]+,[0-9]+\))|don't\(\)|(do\(\))/
    // let regex = /do/
    let result = input.matches(of: regex)
        .map { String($0.0) }
    return result
}

func calculateSumOfMultiplicationsIncludingDosAndDonts(_ input: String) -> Int {
    let instructions = extractMultiplicationsIncludingDosAndDonts(input)
    
    var result = 0
    var multiplicationEnabled = true
    for instruction in instructions {
        switch instruction {
            case "do()":
            multiplicationEnabled = true
            case "don't()": 
            multiplicationEnabled = false
            default:
            if multiplicationEnabled {
                result += performMultiplication(instruction)
            }
        }   
    }

    return result
}

@Suite("To get the first star on day 03") struct Day03Star1Tests {
    let exampleInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

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

@Suite("To get the second star on day 03") struct Day03Star2Tests {
    let exampleInput = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
    
    @Test("we should be able to extract do's and don'ts from the input as well") func extractMultiplicationsDosAndDontsFromInput() {
        let expected = [
            "mul(2,4)",
            "don't()",
            "mul(5,5)",
            "mul(11,8)",
            "do()",
            "mul(8,5)"
        ]

        #expect(extractMultiplicationsIncludingDosAndDonts(exampleInput) == expected)
    }

    @Test("this will not multiply") func dontMultiply() {
        let exampleInput = "don't()mul(2,4)"
        #expect(calculateSumOfMultiplicationsIncludingDosAndDonts(exampleInput) == 0)
    }

    @Test("But this will") func thisWillMultiply() {
        let exampleInput = "don't()do()mul(2,4)"
        #expect(calculateSumOfMultiplicationsIncludingDosAndDonts(exampleInput) == 8)
    }

    @Test("while taking dos and donts into account, calculating the sum of all multiplications should return 48 for the example input") func calculatingTheSumOfMultiplications_forExampleInput() {
        #expect(calculateSumOfMultiplicationsIncludingDosAndDonts(exampleInput) == 48)
    }

    @Test("while taking dos and donts into account, the sum of all multiplications in the actual input should be 70478672") func sumOfMultiplications_forActualInput() {
        #expect(calculateSumOfMultiplicationsIncludingDosAndDonts(input) == 70478672)
    }
}
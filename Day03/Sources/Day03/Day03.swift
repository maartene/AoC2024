func calculateSumOfMultiplications(_ input: String) -> Int {
    let multiplications = extractMultiplicationsWithoutDosAndDonts(input)
    let multiplicationResults = multiplications.map(performMultiplication)
    return multiplicationResults.reduce(0, +)
}

func extractMultiplicationsWithoutDosAndDonts(_ input: String) -> [String] {
    let regex: Regex = /(mul\([0-9]+,[0-9]+\))/
    let result = input.matches(of: regex)
        .map { String($0.0) }
    return result
}

func extractMultiplicationsIncludingDosAndDonts(_ input: String) -> [String] {
    let regex: Regex = /(mul\([0-9]+,[0-9]+\))|don't\(\)|(do\(\))/
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
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
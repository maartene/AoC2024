// MARK: Part 1
func sumOfMiddleNumbersInValidSequences(_ input: String) -> Int {
    let rulesAndSequences = convertInputToRulesAndSequences(input)
    let validSequences = rulesAndSequences.sequences.filter { isValidSequence($0, rules: rulesAndSequences.rules).isValid }
    
    return validSequences.reduce(0) { partialResult, validSequence in
        let middleNumberIndex = validSequence.count / 2
        return partialResult + validSequence[middleNumberIndex]
    }
}

func isValidSequence(_ sequence: [Int], rules: [Rule]) -> (isValid: Bool, violatedRule: Rule?) {
    for numberToCheck in sequence {
        let indexOfNumberToCheck = sequence.firstIndex(of: numberToCheck)!
        
        let applicableRules = rules.filter { $0.numberToPrint == numberToCheck }
        let pagesThatNeedToGoAfterIt = applicableRules.map { $0.before }
        for pageThatShouldBeAfterIt in pagesThatNeedToGoAfterIt {
            if sequence.contains(pageThatShouldBeAfterIt) && sequence.firstIndex(of: pageThatShouldBeAfterIt)! < indexOfNumberToCheck {
                let pageThatShouldBeAfterItIndex = sequence.firstIndex(of: pageThatShouldBeAfterIt)!
                return (false, Rule(numberToPrint: indexOfNumberToCheck, before: pageThatShouldBeAfterItIndex))
            }
        }
    }
    
    return (true, nil)
}

// MARK: Part 2
func sumOfMiddleNumbersInValidMadeInvalidSequences(_ input: String) -> Int {
    let rulesAndSequences = convertInputToRulesAndSequences(input)
    let invalidSequences = rulesAndSequences.sequences.filter { isValidSequence($0, rules: rulesAndSequences.rules).isValid == false }
    let validMadeInvalidSequences = invalidSequences.map { convertInvalidSequenceToValidSequence($0, rules: rulesAndSequences.rules) }
    
    return validMadeInvalidSequences.reduce(0) { partialResult, validSequence in
        let middleNumberIndex = validSequence.count / 2
        return partialResult + validSequence[middleNumberIndex]
    }
}

func convertInvalidSequenceToValidSequence(_ sequence: [Int], rules: [Rule]) -> [Int] {
    var correctedSequence = sequence
    while let toSwap = isValidSequence(correctedSequence, rules: rules).violatedRule {
        correctedSequence.swapAt(toSwap.numberToPrint, toSwap.before)
    }
    
    return correctedSequence
}

// MARK: Input parsing
struct Rule: Equatable {
    let numberToPrint: Int
    let before: Int
}

func convertInputToRulesAndSequences(_ input: String) -> (rules: [Rule], sequences: [[Int]]) {
    let lines = input.split(separator: "\n").map(String.init)
    
    let ruleLines = lines.filter { $0.contains("|") }
    
    let numbersAsStrings = ruleLines.map{ line in
        line.split(separator: "|")
            .map(String.init)
    }
    
    let rules = numbersAsStrings
        .compactMap { numbers in
            if let print = Int(numbers[0]), let before = Int(numbers[1]) {
                return Rule(numberToPrint: print, before: before)
            }
            return nil
    }
    
    let sequenceLines = lines.filter { $0.contains(",") }
    let sequences = sequenceLines.map { line in
        line.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
    }
    
    return (rules, sequences)
}

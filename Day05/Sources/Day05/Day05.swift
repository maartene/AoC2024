// MARK: Part 1
func sumOfMiddleNumbersInValidSequences(_ input: String) -> Int {
    let rulesAndSequences = convertInputToRulesAndSequences(input)
    let validSequences = rulesAndSequences.sequences.filter { isValidSequence($0, rules: rulesAndSequences.rules).isValid }
    
    return sumOfMiddleNumbers(sequences: validSequences)
}

func isValidSequence(_ sequence: [Int], rules: [NumberCombo]) -> (isValid: Bool, violatedRule: NumberCombo?) {
    for numberToCheck in sequence {
        let indexOfNumberToCheck = sequence.firstIndex(of: numberToCheck)!
        
        let applicableRules = rules.filter { $0.numberOne == numberToCheck }
        let pagesThatNeedToGoAfterIt = applicableRules.map { $0.numberTwo }
        for pageThatShouldBeAfterIt in pagesThatNeedToGoAfterIt {
            if let pageThatShouldBeAfterItIndex = sequence.firstIndex(of: pageThatShouldBeAfterIt), pageThatShouldBeAfterItIndex < indexOfNumberToCheck {
                return (false, NumberCombo(numberOne: indexOfNumberToCheck, numberTwo: pageThatShouldBeAfterItIndex))
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
    
    return sumOfMiddleNumbers(sequences: validMadeInvalidSequences)
}

func convertInvalidSequenceToValidSequence(_ sequence: [Int], rules: [NumberCombo]) -> [Int] {
    var correctedSequence = sequence
    while let toSwap = isValidSequence(correctedSequence, rules: rules).violatedRule {
        correctedSequence.swapAt(toSwap.numberOne, toSwap.numberTwo)
    }
    
    return correctedSequence
}

// MARK: Input parsing
struct NumberCombo: Equatable {
    let numberOne: Int
    let numberTwo: Int
}

func sumOfMiddleNumbers(sequences: [[Int]]) -> Int {
    return sequences.reduce(0) { partialResult, sequence in
        let middleNumberIndex = sequence.count / 2
        return partialResult + sequence[middleNumberIndex]
    }
}

func convertInputToRulesAndSequences(_ input: String) -> (rules: [NumberCombo], sequences: [[Int]]) {
    let lines = input.split(separator: "\n").map(String.init)
    
    let ruleLines = lines.filter { $0.contains("|") }
    
    let numbersAsStrings = ruleLines.map{ line in
        line.split(separator: "|")
            .map(String.init)
    }
    
    let rules = numbersAsStrings
        .compactMap { numbers in
            if let print = Int(numbers[0]), let before = Int(numbers[1]) {
                return NumberCombo(numberOne: print, numberTwo: before)
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

func sumOfMiddleNumbersInValidSequences(_ input: String) -> Int {
    let rulesAndSequences = convertInputToRulesAndSequences(input)
    let validSequences = rulesAndSequences.sequences.filter { isValidSequence($0, rules: rulesAndSequences.rules) }
    
    return validSequences.reduce(0) { partialResult, validSequence in
        let middleNumberIndex = validSequence.count / 2
        return partialResult + validSequence[middleNumberIndex]
    }
}

func isValidSequence(_ sequence: [Int], rules: [Rule]) -> Bool {
    for numberToCheck in sequence {
        let indexOfNumberToCheck = sequence.firstIndex(of: numberToCheck)!
        
        let applicableRules = rules.filter { $0.numberToPrint == numberToCheck }
        let pagesThatNeedToGoAfterIt = applicableRules.map { $0.before }
        for pageThatShouldBeAfterIt in pagesThatNeedToGoAfterIt {
            if sequence.contains(pageThatShouldBeAfterIt) && sequence.firstIndex(of: pageThatShouldBeAfterIt)! < indexOfNumberToCheck {
                return false
            }
        }
    }
    
    return true
}

struct Rule: Equatable {
    let numberToPrint: Int
    let before: Int
}

// MARK: Input parsing
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

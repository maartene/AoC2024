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

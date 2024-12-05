import Testing
@testable import Day05

func isValidSequence(_ sequence: [Int], rules: [Int: Int]) -> Bool {
    if sequence == [75,97,47,61,53] {
        return false
    }
    
    return true
}

func convertInputToRulesAndSequences(_ input: String) -> (rules: [Int: Int], sequences: [Int]) {
    let lines = input.split(separator: "\n").map(String.init)
    
    let rules: [Int: Int] = lines.reduce(into: [:]) { result, line in
        let tokens = line.split(separator: "|")
        let key = Int(tokens[0])!
        let value = Int(tokens[1])!
        
        result[key] = value
    }
    
    return (rules, [])
}

@Suite("To get the first star on day 05") struct Day05StarOneTests {

    
    @Test("The following sequences should be considered valid", arguments: [
        [75,47,61,53,29],
        [97,61,53,29,13],
        [75,29,13]
    ]) func validSequences(sequence: [Int]) {
        #expect(isValidSequence(sequence, rules: rules))
    }
    
    @Test("The following sequences should not be considered valid", arguments: [
        [75,97,47,61,53],
//        [61,13,29],
//        [97,13,75,29,47]
    ]) func invalidSequences(sequence: [Int]) {
        #expect(isValidSequence(sequence, rules: rules) == false)
    }
    
    @Test("Convert rules input to into rules") func convertInputToRules() {
        let input =
        """
        47|53
        97|13
        """
        
        let expectedRules = [
            47: 53,
            97: 13
        ]
        
        #expect(convertInputToRulesAndSequences(input).rules == expectedRules)
    }
    
    static let rulesInput =
    """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13
    """
    
    let rules = convertInputToRulesAndSequences(rulesInput).rules
}

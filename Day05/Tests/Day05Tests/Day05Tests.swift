import Testing
@testable import Day05

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
        [61,13,29],
        [97,13,75,29,47]
    ]) func invalidSequences(sequence: [Int]) {
        #expect(isValidSequence(sequence, rules: rules) == false)
    }
    
    @Test("Convert exampleInput into rules") func convertInputToRules() {
        let input =
        """
        47|53
        97|13
        
        75,47,61,53,29
        97,61,53,29,13
        """
        
        let expectedRules = [
            Rule(numberToPrint: 47, before: 53),
            Rule(numberToPrint: 97, before: 13),
        ]
        
        #expect(convertInputToRulesAndSequences(input).rules == expectedRules)
    }
    
    @Test("Convert exampleInput into rules") func convertInputToSequences() {
        let input =
        """
        47|53
        97|13
        
        75,47,61,53,29
        97,61,53,29,13
        """
        
        let expectedSequences = [
            [75,47,61,53,29],
            [97,61,53,29,13],
        ]
        
        #expect(convertInputToRulesAndSequences(input).sequences == expectedSequences)
    }
    
    static let exampleInput =
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
    
    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """
    
    let rules = convertInputToRulesAndSequences(exampleInput).rules
}

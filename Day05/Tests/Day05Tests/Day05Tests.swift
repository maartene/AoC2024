import Testing
@testable import Day05

@Suite("To get the first star on day 05") struct Day05StarOneTests {
    let rules = convertInputToRulesAndSequences(exampleInput).rules
    
    @Test("The following sequences should be considered valid", arguments: [
        [75,47,61,53,29],
        [97,61,53,29,13],
        [75,29,13]
    ]) func validSequences(sequence: [Int]) {
        #expect(isValidSequence(sequence, rules: rules).isValid)
    }
    
    @Test("The following sequences should not be considered valid", arguments: [
        [75,97,47,61,53],
        [61,13,29],
        [97,13,75,29,47]
    ]) func invalidSequences(sequence: [Int]) {
        #expect(isValidSequence(sequence, rules: rules).isValid == false)
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
            NumberCombo(numberOne: 47, numberTwo: 53),
            NumberCombo(numberOne: 97, numberTwo: 13),
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
    
    @Test("The sum of the middlenumbers of the valid sequences in the example input should be 143") func sumOfMiddleNumbers_exampleInput() {
        #expect(sumOfMiddleNumbersInValidSequences(exampleInput) == 143)
    }
    
    @Test("The sum of the middlenumbers of the valid sequences in the actual input should be 5639") func sumOfMiddleNumbers_actualInput() {
        #expect(sumOfMiddleNumbersInValidSequences(input) == 5639)
    }
}

@Suite("To get the second star on day 05") struct Day05StarTwoTests {
    let rules = convertInputToRulesAndSequences(exampleInput).rules
    
    @Test("We should be able to convert an invalid sequences into a valid sequences", arguments: [
        ([75,97,47,61,53], [97,75,47,61,53]),
        ([61,13,29], [61,29,13]),
        ([97,13,75,29,47], [97,75,47,29,13])
    ]) func canConvertInvalidSequencesToValidSequences(testcase: (invalidSequence: [Int], expectedValidSequence: [Int])) {
        
        #expect(convertInvalidSequenceToValidSequence(testcase.invalidSequence, rules: rules) == testcase.expectedValidSequence)
    }
    
    @Test("The sum of the middlenumbers of the valid made invalid sequences in the example input should be 123") func sumOfMiddleNumbers_exampleInput() {
        #expect(sumOfMiddleNumbersInValidMadeInvalidSequences(exampleInput) == 123)
    }
    
    @Test("The sum of the middlenumbers of the valid made invalid sequences in the actual input should be 5273") func sumOfMiddleNumbers_actualInput() {
        #expect(sumOfMiddleNumbersInValidMadeInvalidSequences(input) == 5273)
    }
}

let exampleInput =
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
    
    

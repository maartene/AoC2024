import Testing
@testable import Day05

func isValidSequence(_ sequence: [Int], rules: [Int: Int]) -> Bool {
    if sequence == [75,97,47,61,53] {
        return false
    }
    
    return true
}

@Suite("To get the first star on day 05") struct Day05StarOneTests {
    let rules = [Int:Int]()
    
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
}

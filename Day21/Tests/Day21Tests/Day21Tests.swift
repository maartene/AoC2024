import Testing
@testable import Day21

@Suite("To get the first star on day 21") struct Day21StarOneTests {
    let exampleInput =
    """
    029A
    980A
    179A
    456A
    379A
    """
    
    @Test("The complexity factor of the example input is 126384") func complexityFactorOfExampleInput() {
        #expect(complexityFactor(of: exampleInput) == 126384)
        
        let ways = ways("029A", keyPad: numeric_keys)
        print(ways)
        
        let shortest3 = shortest3("029A")
        print(shortest3.count)
    }
    
    @Test("The complexity factor of the actual input is ?") func complexityFactorOfActualInput() {
        #expect(complexityFactor(of: input) == 0)
    }
}


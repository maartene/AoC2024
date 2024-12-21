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
    }
    
    @Test("Have a robot enter a sequence and validate resulting path length") func validatePathLengthOfExampleInput() {
        #expect(shortestPath(for: "v<<A>>^A<A>AvA<^AA>A<vAAA>^A").count == 68)
    }
}

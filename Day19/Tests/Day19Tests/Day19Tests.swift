import Testing
@testable import Day19

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 19") struct Day19StarOneTests {
    @Test("Only 6 of 8 designs can be made using towels in the example input") func possibleDesignsInExampleInput() {
        let exampleInput =
        """
        r, wr, b, g, bwu, rb, gb, br

        brwrr
        bggr
        gbbr
        rrbgbr
        ubwu
        bwurrg
        brgr
        bbrgwb
        """
        
        #expect(possibleDesigns(in: exampleInput) == 6)
    }
    
}

import Testing
@testable import Day19

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
    
    @Test("The following designs are possible using towels: 'r, wr, b, g, bwu, rb, gb, br'", arguments: [
        "brwrr", "bggr", "gbbr", "rrbgbr", "bwurrg", "brgr"
    ]) func designIsPossibleUsingTowels(design: String) {
        let towelTypes = ["r", "wr", "b", "g", "bwu", "rb", "gb", "br"]
        #expect(isPossibleDesign(design: design, towelTypes: towelTypes))
    }
    
    @Test("The following designs are not possible using towels: 'r, wr, b, g, bwu, rb, gb, br'", arguments: [
        "ubwu", "bbrgwb"
    ]) func designIsNotPossibleUsingTowels(design: String) {
        let towelTypes = ["r", "wr", "b", "g", "bwu", "rb", "gb", "br"]
        #expect(isPossibleDesign(design: design, towelTypes: towelTypes) == false)
    }
    
    @Test("'bwurrg' can be made using towels 'r, wr, b, g, bwu, rb, gb, br'") func bwurrgIsPossible() {
        let towelTypes = ["r", "wr", "b", "g", "bwu", "rb", "gb", "br"]
        #expect(isPossibleDesign(design: "bwurrg", towelTypes: towelTypes))
    }
}




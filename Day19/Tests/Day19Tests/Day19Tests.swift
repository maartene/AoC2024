import Testing
@testable import Day19

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

@Suite("To get the first star on day 19") struct Day19StarOneTests {
    let designChecker = DesignChecker()
    
    @Test("Only 6 of 8 designs can be made using towels in the example input") func possibleDesignsInExampleInput() {
        #expect(possibleDesigns(in: exampleInput) == 6)
    }
    
    @Test("The following designs are possible using towels: 'r, wr, b, g, bwu, rb, gb, br'", arguments: [
        "brwrr", "bggr", "gbbr", "rrbgbr", "bwurrg", "brgr"
    ]) func designIsPossibleUsingTowels(design: String) {
        let towelTypes = ["r", "wr", "b", "g", "bwu", "rb", "gb", "br"]
        #expect(designChecker.isPossibleDesign(design: design, towelTypes: towelTypes))
    }
    
    @Test("The following designs are not possible using towels: 'r, wr, b, g, bwu, rb, gb, br'", arguments: [
        "ubwu", "bbrgwb"
    ]) func designIsNotPossibleUsingTowels(design: String) {
        let towelTypes = ["r", "wr", "b", "g", "bwu", "rb", "gb", "br"]
        #expect(designChecker.isPossibleDesign(design: design, towelTypes: towelTypes) == false)
    }
    
    @Test("'bwurrg' can be made using towels 'r, wr, b, g, bwu, rb, gb, br'") func bwurrgIsPossible() {
        let towelTypes = ["r", "wr", "b", "g", "bwu", "rb", "gb", "br"]
        #expect(designChecker.isPossibleDesign(design: "bwurrg", towelTypes: towelTypes))
    }
    
    @Test("Only 298 of 400 designs can be made using towels in the example input") func possibleDesignsInActualInput() {
        #expect(possibleDesigns(in: input) == 298)
    }
}

@Suite("To get the second star on day 19") struct Day19StarTwoTests {
    let designChecker = DesignChecker()
    
    @Test("There are a total of 16 ways that the towels can be arranged into the valid design configurations in the example input") func totalNumberOfValidDesignConfigurationsInExampleInput() {
        #expect(totalNumberOfValidDesignConfigurations(in: exampleInput) == 16)
    }
    
    @Test("Number of configurations that the towels can be arranged into designs", arguments: [
        ("brwrr", 2),
        ("bggr", 1),
        ("gbgb", 4),  // g b g g,  gb g b, gb gb, g b gb
        ("gbbr", 4),
        ("rrbgbr", 6),
        ("bwurrg", 1),
        ("brgr", 2),
    ]) func numberOfConfigurationsForExample(testcase: (design: String, expectedConfigurationCount: Int)) {
        let towelTypes = ["r", "wr", "b", "g", "bwu", "rb", "gb", "br"]
        #expect(designChecker.numberOfValidDesignConfigurations(design: testcase.design, towelTypes: towelTypes) == testcase.expectedConfigurationCount)
    }
    
    @Test("There are a total of 572248688842069 ways that the towels can be arranged into the valid design configurations in the actual input") func totalNumberOfValidDesignConfigurationsInActualInput() {
        #expect(totalNumberOfValidDesignConfigurations(in: input) == 572248688842069)
    }
}

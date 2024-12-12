import Testing
@testable import Day12

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 12") struct Day12StarOneTests {
    @Test("The area for Plant 'A' in the first example is 4") func areaForPlantInFirstExample() {
        let firstExample =
        """
        AAAA
        BBCD
        BBCC
        EEEC
        """
        
        #expect(areaForPlant(firstExample, plant: "A") == 4)
    }
}

import Testing
@testable import Day12

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}



@Suite("To get the first star on day 12") struct Day12StarOneTests {
    let firstExample =
        """
        AAAA
        BBCD
        BBCC
        EEEC
        """
    
    let secondExample =
        """
        OOOOO
        OXOXO
        OOOOO
        OXOXO
        OOOOO
        """
    
    @Test("The area for a plant in the first example should return the correct expected area", arguments: [
        ("A", 4),
        ("B", 4),
        ("C", 4),
        ("D", 1),
        ("E", 3),
    ]) func areaForPlantInFirstExample(testcase: (plant: Character, expectedArea: Int)) {
        #expect(areaForPlant(firstExample, plant: testcase.plant) == testcase.expectedArea)
    }
    
    @Test("The perimeter for a plant in the first example should return the correct expected perimeter", arguments: [
        ("A", 10),
        ("B", 8),
        ("C", 10),
        ("D", 4),
        ("E", 8),
    ]) func perimeterForPlantInFirstExample(testcase: (plant: Character, expectedArea: Int)) {
        #expect(perimeterForPlant(firstExample, plant: testcase.plant) == testcase.expectedArea)
    }
    
    @Test("The perimeter for a plant in the second example should return the correct expected perimeter", arguments: [
        ("O", 36),
        ("X", 16),
    ]) func perimeterForPlantInSecondExample(testcase: (plant: Character, expectedArea: Int)) {
        #expect(perimeterForPlant(secondExample, plant: testcase.plant) == testcase.expectedArea)
    }
    
    @Test("The number of regions per plant in the first example should be one", arguments: [
        "A", "B", "C", "D", "E"
    ]) func numberOfRegionsInFirstExample(plant: Character) {
        #expect(regionsForPlant(firstExample, plant: plant).count == 1)
    }
    
    @Test("The number of regions per plant in the second example should be", arguments: [
        ("O", 1),
        ("X", 4),
    ]) func numberOfRegionsInSecondExample(testcase: (plant: Character, expectedRegionCount: Int)) {
        #expect(regionsForPlant(secondExample, plant: testcase.plant).count == testcase.expectedRegionCount)
    }
    
    @Test("The total price for the first example is 140") func totalCostForRegionsInFirstExample() {
        #expect(totalCostForRegions(firstExample) == 140)
    }
    
    @Test("The price per plant in the second example should be", arguments: [
        ("O", 756),
        ("X", 16)
    ]) func pricePerPlantInSecondExample(testcase: (plant: Character, expectedArea: Int)) {
        #expect(pricePerPlant(secondExample, plant: testcase.plant) == testcase.expectedArea)
    }
    
//    @Test("The total price for the second example is 772") func totalCostForRegionsInSecondExample() {
//        #expect(totalCostForRegions(secondExample) == 772)
//    }
}

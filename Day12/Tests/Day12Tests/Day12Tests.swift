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
        let secondExample =
        """
        OOOOO
        OXOXO
        OOOOO
        OXOXO
        OOOOO
        """
        
        #expect(perimeterForPlant(secondExample, plant: testcase.plant) == testcase.expectedArea)
    }
}

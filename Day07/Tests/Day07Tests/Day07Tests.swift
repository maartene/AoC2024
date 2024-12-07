import Testing
@testable import Day07

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 07") struct Day07StarOneTests {
    @Test("An input of '10: 1 2' cannot be made true") func equationThatCannotBeMadeTrue() {
        let equation = "10: 1 2"
        #expect(equationCanBeMadeTrue(equation) == false)
    }
    
    @Test("These equations can be made true:", arguments: [
        "10: 2 5",
        "7: 2 5",
        "3267: 81 40 27"
    ]) func equationsThatCanBeMadeTrue(equation: String) {
        #expect(equationCanBeMadeTrue(equation) == true)
    }
}

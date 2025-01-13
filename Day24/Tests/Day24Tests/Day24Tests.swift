import Testing
@testable import Day24

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 24") struct Day24StarOneTests {
    @Test("The output for the small example should be 4") func smallExample() {
        let smallExampleInput =
        """
        x00: 1
        x01: 1
        x02: 1
        y00: 0
        y01: 1
        y02: 0

        x00 AND y00 -> z00
        x01 XOR y01 -> z01
        x02 OR y02 -> z02
        """
        
        #expect(numberValueResultingFromCircuit(smallExampleInput) == 4)
    }
}

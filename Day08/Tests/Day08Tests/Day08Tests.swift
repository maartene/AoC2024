import Testing
@testable import Day08

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 08") struct Day08StarOneTests {
    @Test("An empty map has no antinodes") func antinodes_forEmptyMap() {
        let map = ""
        #expect(calculateNumberOfAntinodePositions(in: map) == 0)
    }
}

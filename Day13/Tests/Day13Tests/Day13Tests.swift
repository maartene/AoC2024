import Testing
@testable import Day13

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on Day 13") struct Day13StarOneTests {
    @Test("To get the prize in machine one for minimal cost means pressing the A button 80 times and the B button 40 times") func buttonPressesForMachineOneInTheExampleInput() throws {
        let machineOneInput =
        """
        Button A: X+94, Y+34
        Button B: X+22, Y+67
        Prize: X=8400, Y=5400
        """
        
        let result = try #require(minimalCostButtonPressesForMachine(machineOneInput))
        #expect(result == (80, 40))
    }
}

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
    
    @Test("To get the prize in machine three for minimal cost means pressing the A button 38 times and the B button 86 times") func buttonPressesForMachineTwoInTheExampleInput() throws {
        let machineThreeInput =
        """
        Button A: X+17, Y+86
        Button B: X+84, Y+37
        Prize: X=7870, Y=6450
        """
        
        let result = try #require(minimalCostButtonPressesForMachine(machineThreeInput))
        #expect(result == (38, 86))
    }
    
    @Test("Machines two and four can't give out prizes", arguments: [
                """
                Button A: X+26, Y+66
                Button B: X+67, Y+21
                Prize: X=12748, Y=12176
                """,
                """
                Button A: X+69, Y+23
                Button B: X+27, Y+71
                Prize: X=18641, Y=10279
                """
                
    ]) func machinesTwoAndFourCantGiveOutPrizes(machineString: String) throws {
        #expect(minimalCostButtonPressesForMachine(machineString) == nil)
    }
}

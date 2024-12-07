import Testing
@testable import Day07

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 07") struct Day07StarOneTests {
    @Test("An input of '10: 1 2' cannot be made true") func equationThatCannotBeMadeTrue() {
        let equation = Equation("10: 1 2")
        #expect(equationCanBeMadeTrue(equation) == false)
    }
    
    @Test("These equations can be made true:", arguments: [
        "10: 2 5",
        "7: 2 5",
        "3267: 81 40 27",
        "292: 11 6 16 20",
        "21: 1 2 3 4 5 6"
    ]) func equationsThatCanBeMadeTrue(equation: String) {
        #expect(equationCanBeMadeTrue(Equation(equation)) == true)
    }
    
    @Test("Creation of operations") func creationOfOperations() {
        let operations = createOperations(maxOperators: 3)
        let expectedOperations: [[Character]] = [
            [],
            ["*"],
            ["+"],
            ["+", "*"],
            ["*", "+"],
            ["+", "+"],
            ["*", "*"],
            ["*", "*", "*"],
            ["*", "*", "+"],
            ["*", "+", "*"],
            ["*", "+", "+"],
            ["+", "*", "*"],
            ["+", "*", "+"],
            ["+", "+", "*"],
            ["+", "+", "+"],
        ]
        
        for operation in operations {
            print(operation)
        }
        
        #expect(operations.count == expectedOperations.count)
        for operation in operations {
            #expect(expectedOperations.contains(operation))
        }
    }
    
    let exampleInput =
    """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """
    
    @Test("In the example input only three equations should be true") func numberOfTrueEquationsInExampleInput() {
        let equations = convertInputToEquations(exampleInput)
        
        let trueEquations = equations.filter(equationCanBeMadeTrue)
        
        #expect(trueEquations.count == 3)
    }
    
    @Test("The total calibration result of the example input should be 3749") func totalCalibrationResult_forExampleInput() {
        #expect(totalCalibrationResult(for: exampleInput) == 3749)
    }
}

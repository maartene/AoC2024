import Foundation

struct Equation {
    let expectedNumber: Int
    let numbersToPlayAroundWith: [Int]
    
    init(_ equationString: String) {
        let split = equationString.split(separator: ":").map(String.init)
        expectedNumber = Int(split[0])!
        
        numbersToPlayAroundWith = split[1].split(separator: " ").map(String.init).compactMap(Int.init)
    }
    
    var expectedOperatorCount: Int {
        numbersToPlayAroundWith.count - 1
    }
    
    func equationCanBeMadeTrue() -> Bool {
        let operations = createOperations(maxOperators: expectedOperatorCount)
        
        let relevantOperations = operations.filter { $0.count == expectedOperatorCount }
        
        for relevantOperation in relevantOperations {
            var result = numbersToPlayAroundWith[0]
            for i in 0 ..< relevantOperation.count {
                switch relevantOperation[i] {
                case "+":
                    result += numbersToPlayAroundWith[i + 1]
                case "*":
                    result *= numbersToPlayAroundWith[i + 1]
                default:
                    fatalError("Only '+' and '*' are permitted as operators.")
                }
            }
            
            if result == expectedNumber {
                return true
            }
        }
        return false
    }
}

func totalCalibrationResult(for input: String) -> Int {
    let equations = convertInputToEquations(input)
    
    let trueEquations = equations.filter { $0.equationCanBeMadeTrue() }
    
    return trueEquations.map { $0.expectedNumber }
        .reduce(0, +)
}



func createOperations(maxOperators: Int) -> Set<[Character]> {
    var result: Set<[Character]> = [[]]
    
    for _ in  0 ..< maxOperators {
        for operation in result {
            var plusOperation = operation
            plusOperation.append("+")
            
            var multiplyOperation = operation
            multiplyOperation.append("*")
            
            result.insert(plusOperation)
            result.insert(multiplyOperation)
        }
    }
    
    return result
}

func convertInputToEquations(_ input: String) -> [Equation] {
    input.split(separator: "\n").map(String.init).map(Equation.init)
}

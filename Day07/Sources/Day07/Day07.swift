import Foundation

func equationCanBeMadeTrue(_ equation: String) -> Bool {
    let split = equation.split(separator: ":").map(String.init)
    let expectedNumber = Int(split[0])
    
    let numbersToPlayAroundWith = split[1].split(separator: " ").map(String.init).compactMap(Int.init)
    
    let operations = createOperations(maxOperators: numbersToPlayAroundWith.count - 1)
    
    let relevantOperations = operations.filter { $0.count == numbersToPlayAroundWith.count - 1 }
    
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

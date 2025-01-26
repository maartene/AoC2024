import Algorithms
import Foundation

// The Swift Programming Language
// https://docs.swift.org/swift-book
func numberValueResultingFromCircuit(_ input: String) -> Int {
    // get the state from the input
    let state = getStateFromInput(input)
    let instructions = getInstructionsFromInput(input)
    
    let circuit = Circuit(initialState: state, instructions: instructions)
    
    let outputInstructions = instructions.filter { $0.resultKey.hasPrefix("z") }
    circuit.runInstructions(outputInstructions)

    return getNumberFromState(circuit.state)
}

class Circuit {
    var state: [String: Int]
    var instructions: [Instruction]
    
    init(initialState: [String : Int], instructions: [Instruction]) {
        self.state = initialState
        self.instructions = instructions
    }
    
    func runInstructions(_ instructionsToRun: [Instruction]) {
        for instruction in instructionsToRun {
            state[instruction.resultKey] = evaluateInstruction(instruction)
        }
    }
    
    func evaluateInstruction(_ instruction: Instruction) -> Int {
        switch instruction.operation {
        case "AND":
            return AND(instruction.key1, instruction.key2)
        case "OR":
            return OR(instruction.key1, instruction.key2)
        case "XOR":
            return XOR(instruction.key1, instruction.key2)
        default:
            fatalError("Unrecognized operation: \(instruction.operation)")
        }
    }
    
    func gate(key: String) -> Int {
        state[key] ?? evaluateInstruction(
            instructions.first(where: { $0.resultKey == key })!)
    }
    
    func AND(_ stateKey1: String, _ stateKey2: String) -> Int {
        if gate(key: stateKey1) == 1 && gate(key: stateKey2) == 1 {
            return 1
        }
        return 0
    }

    func XOR(_ stateKey1: String, _ stateKey2: String) -> Int {
        if gate(key: stateKey1) != gate(key: stateKey2) {
            return 1
        }
        return 0
    }

    func OR(_ stateKey1: String, _ stateKey2: String) -> Int {
        if gate(key: stateKey1) == 1 || gate(key: stateKey2) == 1 {
            return 1
        }
        return 0
    }
}

func getNumberFromState(_ state: [String: Int], prefix: String = "z") -> Int {
    let zKeys = state.keys.filter( { $0.hasPrefix(prefix) })
    var number = 0
    for stateKey in zKeys.sorted(by: >) {
        number = number << 1
        number += state[stateKey, default: 0]
    }
    
    return number
}

func getStateFromInput(_ input: String) -> [String: Int] {
    let lines = input.split(separator: "\n").map { String($0) }
    let stateLines = lines.filter { $0.contains(":") }
    let state: [String: Int] = stateLines
        .reduce(into: [String: Int]()) { result, string in
            let parts = string.split(separator: ":")
            let stateKey = String(parts[0])
            let stateValue = Int(parts[1].trimmingPrefix(" "))
            result[stateKey] = stateValue
        }
    
    return state
}

typealias Instruction = (key1: String, operation: String, key2: String, resultKey: String)

func getInstructionsFromInput(_ input: String) -> [Instruction] {
    // get instructions from input
    let lines = input.split(separator: "\n").map { String($0) }
    let instructionLines = lines.filter { $0.contains("->") }
    let instuctions: [Instruction] = instructionLines.map { line in
        let parts = line.split(separator: " ").map { String($0) }
        return (parts[0], parts[1], parts[2], parts[4])
    }
    return instuctions
}

// MARK: Part 2
func getNumberFromStateReversed(_ state: [String: Int], prefix: String = "z") -> Int {
    let zKeys = state.keys.filter( { $0.hasPrefix(prefix) })
    var number = 0
    for stateKey in zKeys.sorted(by: <) {
        number = number << 1
        number += state[stateKey, default: 0]
    }
    
    return number
}

struct Swap {
    let a: String
    let b: String
}

extension Swap: Equatable {
    static func == (lhs: Swap, rhs: Swap) -> Bool {
        (lhs.a == rhs.a && lhs.b == rhs.b) ||
        (lhs.b == rhs.a && lhs.a == rhs.b)
    }
}

func wiresToSwap(in input: String, swaps: Int, expectedResult: Int) -> String {
    let initialState = getStateFromInput(input)
    let instructions = getInstructionsFromInput(input)
        
    let swaps = instructions.map { $0.resultKey }.combinations(ofCount: 2)
        .map { swap in
            Swap(a: swap[0], b: swap[1])
        }

    guard swaps.contains(Swap(a: "z05", b: "z00")) else {
        return "Missing swap z05 <-> z00"
    }
    
    guard swaps.contains(Swap(a: "z02", b: "z01")) else {
        return "Missing swap z02 <-> z01"
    }
    
    for swap1 in swaps {
        for swap2 in swaps where swap1 != swap2 {
            
            var swappedInstructions = instructions
            
            if let swapOneNumber1Index = instructions.firstIndex(where: { $0.resultKey == swap1.a } ),
               let swapOneNumber2Index = instructions.firstIndex(where: { $0.resultKey == swap1.b } ),
               let swapTwoNumber1Index = instructions.firstIndex(where: { $0.resultKey == swap2.a } ),
               let swapTwoNumber2Index = instructions.firstIndex(where: { $0.resultKey == swap2.b } ) {
                swappedInstructions[swapOneNumber1Index].resultKey = swap1.b
                swappedInstructions[swapOneNumber2Index].resultKey = swap1.a
                swappedInstructions[swapTwoNumber1Index].resultKey = swap2.b
                swappedInstructions[swapTwoNumber2Index].resultKey = swap2.a
                
                if swap1 == Swap(a: "z05", b: "z00") && swap2 == Swap(a: "z02", b: "z01") {
                    print("Testing correct swaps")
                    
                    for instruction in swappedInstructions {
                        print(instruction)
                    }
                }
                
                
                
                let circuit = Circuit(initialState: initialState, instructions: swappedInstructions)
                circuit.runInstructions(swappedInstructions)
                
                let resultingNumber = getNumberFromState(circuit.state)
                
                if resultingNumber == expectedResult {
                    return "z00,z01,z02,z05"
                }
            }
        }
        
    }

    return ""
}

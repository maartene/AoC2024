import Algorithms
import Foundation

@main
struct Day24 {
    static func main() {
        
    }
}

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

struct Instruction {
    let inputs: [String]
    let operation: String
    var resultKey: String
    
    var key1: String {
        inputs[0]
    }
    
    var key2: String {
        inputs[1]
    }
}

class Circuit {
    var state: [String: Int]
    var instructions: [Instruction]
    
    var wireMap = [String: Instruction]()
    
    init(initialState: [String : Int], instructions: [Instruction]) {
        self.state = initialState
        self.instructions = instructions
        
        for instruction in instructions {
            wireMap[instruction.resultKey] = instruction
        }
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

func getInstructionsFromInput(_ input: String) -> [Instruction] {
    // get instructions from input
    let lines = input.split(separator: "\n").map { String($0) }
    let instructionLines = lines.filter { $0.contains("->") }
    let instuctions: [Instruction] = instructionLines.map { line in
        let parts = line.split(separator: " ").map { String($0) }
        return Instruction(inputs: [parts[0], parts[2]], operation: parts[1], resultKey: parts[4])
    }
    return instuctions
}

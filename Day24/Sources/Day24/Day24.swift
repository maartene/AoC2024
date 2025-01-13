// The Swift Programming Language
// https://docs.swift.org/swift-book
func numberValueResultingFromCircuit(_ input: String) -> Int {
    // get the state from the input
    var state = getStateFromInput(input)
    
    let instructions = getInstructionsFromInput(input)
    
    let outputInstructions = instructions.filter { $0.resultKey.hasPrefix("z") }
    
    for instruction in outputInstructions {
        state[instruction.resultKey] = parseInstruction(instruction, in: state, instructions: instructions)
    }
    
    return getNumberFromState(state)
}

func parseInstruction(_ instruction: Instruction, in state: [String: Int], instructions: [Instruction]) -> Int {
    switch instruction.operation {
    case "AND":
        return AND(instruction.key1, instruction.key2, in: state, instructions: instructions)
    case "OR":
        return OR(instruction.key1, instruction.key2, in: state, instructions: instructions)
    case "XOR":
        return XOR(instruction.key1, instruction.key2, in: state, instructions: instructions)
    default:
        fatalError("Unrecognized operation: \(instruction.operation)")
    }
}

func AND(_ stateKey1: String, _ stateKey2: String, in state: [String: Int], instructions: [Instruction]) -> Int {
    let stateValue1 = state[stateKey1] ?? parseInstruction(
        instructions.first(where: { $0.resultKey == stateKey1 })!,
        in: state, instructions: instructions)
    
    let stateValue2 = state[stateKey2] ?? parseInstruction(
        instructions.first(where: { $0.resultKey == stateKey2 })!,
        in: state, instructions: instructions)
    
    if stateValue1 == 1 && stateValue2 == 1 {
        return 1
    }
    return 0
}

func XOR(_ stateKey1: String, _ stateKey2: String, in state: [String: Int], instructions: [Instruction]) -> Int {
    let stateValue1 = state[stateKey1] ?? parseInstruction(
        instructions.first(where: { $0.resultKey == stateKey1 })!,
        in: state, instructions: instructions)
    
    let stateValue2 = state[stateKey2] ?? parseInstruction(
        instructions.first(where: { $0.resultKey == stateKey2 })!,
        in: state, instructions: instructions)
    
    if stateValue1 != stateValue2 {
        return 1
    }
    return 0
}

func OR(_ stateKey1: String, _ stateKey2: String, in state: [String: Int], instructions: [Instruction]) -> Int {
    let stateValue1 = state[stateKey1] ?? parseInstruction(
        instructions.first(where: { $0.resultKey == stateKey1 })!,
        in: state, instructions: instructions)
    
    let stateValue2 = state[stateKey2] ?? parseInstruction(
        instructions.first(where: { $0.resultKey == stateKey2 })!,
        in: state, instructions: instructions)
    
    if stateValue1 == 1 || stateValue2 == 1 {
        return 1
    }
    return 0
}

func getNumberFromState(_ state: [String: Int]) -> Int {
    let zKeys = state.keys.filter( { $0.hasPrefix("z") })
    
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

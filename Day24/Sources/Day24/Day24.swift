// The Swift Programming Language
// https://docs.swift.org/swift-book
func numberValueResultingFromCircuit(_ input: String) -> Int {
    func AND(_ stateKey1: String, _ stateKey2: String) -> Int {
        if state[stateKey1] == 1 && state[stateKey2] == 1 {
            return 1
        }
        return 0
    }
    
    func XOR(_ stateKey1: String, _ stateKey2: String) -> Int {
        if state[stateKey1] != state[stateKey2] {
            return 1
        }
        return 0
    }
    
    func OR(_ stateKey1: String, _ stateKey2: String) -> Int {
        if state[stateKey1] == 1 || state[stateKey2] == 1 {
            return 1
        }
        return 0
    }

    // get the state from the input
    var state = getStateFromInput(input)
    
    // apply instructions to determine the end state
    state["z00"] = AND("x00", "y00")
    state["z01"] = XOR("x01", "y01")
    state["z02"] = OR("x02", "y02")
    
    // Construct the resulting number
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

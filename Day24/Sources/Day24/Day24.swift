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

    
    var state = [
        "x00": 1,
        "x01": 1,
        "x02": 1,
        "y00": 0,
        "y01": 1,
        "y02": 0,
    ]
    
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


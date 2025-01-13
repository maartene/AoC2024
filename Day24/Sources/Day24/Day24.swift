// The Swift Programming Language
// https://docs.swift.org/swift-book
func numberValueResultingFromCircuit(_ input: String) -> Int {
    let state = [
        "x00": 1,
        "x01": 1,
        "x02": 1,
        "y00": 0,
        "y01": 1,
        "y02": 0,
        "z00": 0,
        "z01": 0,
        "z02": 1
    ]
    
    // Construct the resulting number
    let zKeys = state.keys.filter( { $0.hasPrefix("z") })
    var number = 0
    for stateKey in zKeys.sorted(by: >) {
        number = number << 1
        number += state[stateKey, default: 0]
    }
    
    return number
}

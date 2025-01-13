// The Swift Programming Language
// https://docs.swift.org/swift-book
func numberValueResultingFromCircuit(_ input: String) -> Int {
    let output = [
        "z00": 0,
        "z01": 0,
        "z02": 1
    ]
    
    
    // Construct the resulting number
    var number = 0
    for outputKey in output.keys.sorted(by: >) {
        number = number << 1
        number += output[outputKey, default: 0]
    }
    
    return number
}

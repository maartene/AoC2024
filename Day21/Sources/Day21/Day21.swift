import Foundation

func complexityFactor(of input: String) -> Int {
    let sequences = input.split(separator: "\n").map(String.init)
    
    let complexityOfIndidivualCodes = sequences.map(complexityFactorForSequence)
    
    return complexityOfIndidivualCodes.reduce(0, +)
}

func complexityFactorForSequence(_ sequence: String) -> Int {
    let shortestPathLengths = [
        "029A": 68,
        "980A": 60,
        "179A": 68,
        "456A": 64,
        "379A": 64
    ]
     
    let numericValueOfSequenceString = String(sequence.matches(of: /\d+/)[0].0)
    
    let numericValueOfSequence = Int(numericValueOfSequenceString) ?? 0
    
    return shortestPathLengths[sequence, default: 0] * numericValueOfSequence
}

func shortestPath(for sequence: String) -> [Character] {
    let result = "<vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A".map(Character.init)
    return result
}


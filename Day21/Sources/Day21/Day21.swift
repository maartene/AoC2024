import Foundation
import Shared


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

func shortestPath(for sequenceString: String) -> String {
    //     +---+---+
    //    | ^ | A |
    //+---+---+---+
    //| < | v | > |
    //+---+---+---+
    
    
    struct KeypadMovement {
        let from: Character
        let to: Character
        let sequence: String
    }
    
    let keypadMovements: [KeypadMovement] = [
        // A -> ?
        KeypadMovement(from: "A", to: "A", sequence: "A"),
        KeypadMovement(from: "A", to: "^", sequence: "<A"),
        KeypadMovement(from: "A", to: ">", sequence: "vA"),
        KeypadMovement(from: "A", to: "v", sequence: "<vA"),
        KeypadMovement(from: "A", to: "<", sequence: "v<<A"),
        
        // ^ -> ?
        KeypadMovement(from: "^", to: "A", sequence: ">A"),
        KeypadMovement(from: "^", to: "^", sequence: "A"),
        KeypadMovement(from: "^", to: ">", sequence: "v>A"),
        KeypadMovement(from: "^", to: "v", sequence: "vA"),
        KeypadMovement(from: "^", to: "<", sequence: "v<A"),
        
        // < -> ?
        KeypadMovement(from: "<", to: "A", sequence: ">>^A"),
        KeypadMovement(from: "<", to: "^", sequence: ">^A"),
        KeypadMovement(from: "<", to: ">", sequence: ">>A"),
        KeypadMovement(from: "<", to: "v", sequence: ">A"),
        KeypadMovement(from: "<", to: "<", sequence: "A"),
        
        // v -> ?
        KeypadMovement(from: "v", to: "A", sequence: "^>A"),
        KeypadMovement(from: "v", to: "^", sequence: "^A"),
        KeypadMovement(from: "v", to: ">", sequence: ">A"),
        KeypadMovement(from: "v", to: "v", sequence: "A"),
        KeypadMovement(from: "v", to: "<", sequence: "<A"),
        
        // > -> ?
        KeypadMovement(from: ">", to: "A", sequence: "^A"),
        KeypadMovement(from: ">", to: "^", sequence: "<^A"),
        KeypadMovement(from: ">", to: ">", sequence: "A"),
        KeypadMovement(from: ">", to: "v", sequence: "<A"),
        KeypadMovement(from: ">", to: "<", sequence: "<<A"),
        
        // A -> #
        KeypadMovement(from: "A", to: "0", sequence: "<A"),
        KeypadMovement(from: "A", to: "1", sequence: "^<<A"),
        KeypadMovement(from: "A", to: "2", sequence: "^<A"),
        KeypadMovement(from: "A", to: "3", sequence: "^A"),
        KeypadMovement(from: "A", to: "4", sequence: "^^<<A"),
        KeypadMovement(from: "A", to: "5", sequence: "^^<A"),
        KeypadMovement(from: "A", to: "6", sequence: "^^A"),
        KeypadMovement(from: "A", to: "7", sequence: "^^^<<A"),
        KeypadMovement(from: "A", to: "8", sequence: "^^^<A"),
        KeypadMovement(from: "A", to: "9", sequence: "^^^A"),
        
        // 0 -> #
        KeypadMovement(from: "0", to: "A", sequence: ">A"),
        KeypadMovement(from: "0", to: "0", sequence: "A"),
        KeypadMovement(from: "0", to: "1", sequence: "^<A"),
        KeypadMovement(from: "0", to: "2", sequence: "^A"),
        KeypadMovement(from: "0", to: "3", sequence: "^>A"),
        KeypadMovement(from: "0", to: "4", sequence: "^^<A"),
        KeypadMovement(from: "0", to: "5", sequence: "^^A"),
        KeypadMovement(from: "0", to: "6", sequence: "^^>A"),
        KeypadMovement(from: "0", to: "7", sequence: "^^^<A"),
        KeypadMovement(from: "0", to: "8", sequence: "^^^A"),
        KeypadMovement(from: "0", to: "9", sequence: "^^^>A"),
        
        // 2 -> #
        KeypadMovement(from: "2", to: "A", sequence: ">vA"),
        KeypadMovement(from: "2", to: "0", sequence: "vA"),
        KeypadMovement(from: "2", to: "1", sequence: "<A"),
        KeypadMovement(from: "2", to: "2", sequence: "A"),
        KeypadMovement(from: "2", to: "3", sequence: ">A"),
        KeypadMovement(from: "2", to: "4", sequence: "^<A"),
        KeypadMovement(from: "2", to: "5", sequence: "^A"),
        KeypadMovement(from: "2", to: "6", sequence: "^>A"),
        KeypadMovement(from: "2", to: "7", sequence: "^^<A"),
        KeypadMovement(from: "2", to: "8", sequence: "^^A"),
        KeypadMovement(from: "2", to: "9", sequence: "^^>A"),
        
        // 9 -> #
        KeypadMovement(from: "9", to: "A", sequence: "vvvA"),
        KeypadMovement(from: "9", to: "0", sequence: "vvv<A"),
        KeypadMovement(from: "9", to: "1", sequence: "vv<<A"),
        KeypadMovement(from: "9", to: "2", sequence: "vv<A"),
        KeypadMovement(from: "9", to: "3", sequence: "vvA"),
        KeypadMovement(from: "9", to: "4", sequence: "v<<A"),
        KeypadMovement(from: "9", to: "5", sequence: "v<A"),
        KeypadMovement(from: "9", to: "6", sequence: "vA"),
        KeypadMovement(from: "9", to: "7", sequence: "<<A"),
        KeypadMovement(from: "9", to: "8", sequence: "<A"),
        KeypadMovement(from: "9", to: "9", sequence: "A"),
        
    ]
    
    let sequence = sequenceString.map(Character.init)
    var position: Character = "A"
    var result = ""
    for entry in sequence {
        result += keypadMovements.first(where: { $0.from == position && $0.to == entry})?.sequence ?? ""
        position = entry
    }
    
    print(result)
    
    return result
}

import Foundation
import Shared
import Collections
import Algorithms



let numeric_keys: [Character: Vector] = [
    "7": Vector(x: 0, y: 0),
    "8": Vector(x: 1, y: 0),
    "9": Vector(x: 2, y: 0),
    "4": Vector(x: 0, y: 1),
    "5": Vector(x: 1, y: 1),
    "6": Vector(x: 2, y: 1),
    "1": Vector(x: 0, y: 2),
    "2": Vector(x: 1, y: 2),
    "3": Vector(x: 2, y: 2),
    "0": Vector(x: 1, y: 3),
    "A": Vector(x: 2, y: 3),
]

let directions_keys: [Character: Vector] = [
    "^": Vector(x: 1, y: 0),
    "A": Vector(x: 2, y: 0),
    "<": Vector(x: 0, y: 1),
    "v": Vector(x: 1, y: 1),
    ">": Vector(x: 2, y: 1),
]

let dd: [Character: Vector] = [
    ">": Vector(x: 1, y: 0),
    "v": Vector(x: 0, y: 1),
    "<": Vector(x: -1, y: 0),
    "^": Vector(x: 0, y: -1),
]

func ways(_ code: String, keyPad: [Character: Vector]) -> [String] {
    // Number of ways to press code on given keypad
    
    var parts = [[String]]()
    var cur_loc = keyPad["A"]!
    
    for c in code {
        // Get to this position
        let next_loc = keyPad[c]!
        let di = next_loc.y - cur_loc.y
        let dj = next_loc.x - cur_loc.x
        
        var moves = ""
        if di > 0 {
            moves += String(repeating: "v", count: di)
        } else if di < 0 {
            moves += String(repeating: "^", count: -di)
        }
        if dj > 0 {
            moves += String(repeating: ">", count: dj)
        } else if dj < 0 {
            moves += String(repeating: "<", count: -dj)
        }
        
        let movesArray = moves.map(Character.init)
        let raw_combos = Set(movesArray.permutations().map { $0 + "A" })

        var combos: Set<[Character]> = []
        for combo in raw_combos {
            let comboToCheck = Array(combo.dropLast())
            var position = cur_loc
            var good = true
            for c in comboToCheck {
                let direction = dd[c]!
                position += direction
                if keyPad.values.contains(position) == false {
                    good = false
                }
            }
            
            if good {
                combos.insert(combo)
            }
        }
        
        let combosAsStrings = combos.map{ combo in combo.map(String.init).joined() }
        
        parts.append(combosAsStrings)
        cur_loc = next_loc
    }
    
    let permutations = cartesianProduct(parts)
    return permutations.map {
        $0.joined()
    }
}

func shortest3(_ code: String) -> String {
    let ways1 = ways(code, keyPad: numeric_keys)
    var ways2: [String] = []
    for way in ways1 {
        ways2.append(contentsOf: ways(way, keyPad: directions_keys))
    }
    var ways3: [String] = []
    for way in ways2 {
        ways3.append(contentsOf: ways(way, keyPad: directions_keys))
    }
    
    return ways3.min(by: { $0.count < $1.count }) ?? ""
    
}


func cartesianProduct(_ arrays: [[String]]) -> [[String]] {
    guard let firstArray = arrays.first else { return [[]] }
    
    let rest = Array(arrays.dropFirst())
    let restProduct = cartesianProduct(rest)
    
    return firstArray.flatMap { item in
        restProduct.map { [item] + $0 }
    }
}


func complexityFactor(of input: String) -> Int {
    let sequences = input.split(separator: "\n").map(String.init)
    
    let complexityOfIndidivualCodes = sequences.map(complexityFactorForSequence)
    
    return complexityOfIndidivualCodes.reduce(0, +)
}

func complexityFactorForSequence(_ sequence: String) -> Int {
    let numericValueOfSequenceString = String(sequence.matches(of: /\d+/)[0].0)
    
    let numericValueOfSequence = Int(numericValueOfSequenceString) ?? 0
    
    let shortestPathLength = shortest3(sequence).count
        
    return shortestPathLength * numericValueOfSequence
}

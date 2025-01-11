import Algorithms
import Collections
import Foundation
import Shared

func complexityFactor(of input: String, intermediateRobots: Int = 2) -> Int {
    let ic = InstructionCreator()

    let sequences = input.split(separator: "\n").map(String.init)

    let complexityOfIndidivualCodes = sequences.map {
        ic.complexityFactorForSequence($0, intermediateRobots: intermediateRobots)
    }

    return complexityOfIndidivualCodes.reduce(0, +)
}

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

// MARK: Actual computation
class InstructionCreator {
    func complexityFactorForSequence(_ sequence: String, intermediateRobots: Int) -> Int {
        let numericValueOfSequenceString = String(sequence.matches(of: /\d+/)[0].0)

        let numericValueOfSequence = Int(numericValueOfSequenceString) ?? 0

        let shortestPathLength = shortest3(sequence)

        return shortestPathLength * numericValueOfSequence
    }

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

            let combosAsStrings = combos.map { combo in combo.map(String.init).joined() }

            parts.append(combosAsStrings)
            cur_loc = next_loc
        }

        let permutations = cartesianProduct(parts)
        let result = permutations.map {
            $0.joined()
        }

        return result
    }

    func shortest3(_ code: String) -> Int {
        let ways1 = ways(code, keyPad: numeric_keys)
        let result = shortest(inputWays: ways1, depth: 2)
        return result
    }

    func shortest(inputWays: [String], depth: Int) -> Int {
        if depth == 0 {
            let result = inputWays.min(by: { $0.count < $1.count })?.count ?? 0
            return result
        }

        var newWays = [String]()
        for way in inputWays {
            newWays.append(contentsOf: ways(way, keyPad: directions_keys))
        }

        let result = shortest(inputWays: newWays, depth: depth - 1)
        return result
    }
}

//func generate_ways(from a: Character, to b: Character, directionalKeypad: Bool) -> Set<[Character]> {
//    let keypad = directionalKeypad ? directions_keys : numeric_keys
//
//    let cur_loc = keypad[a]!
//    let next_loc = keypad[b]!
//    let di = next_loc.y - cur_loc.y
//    let dj = next_loc.x - cur_loc.x
//
//    var moves = ""
//    if di > 0 {
//        moves += String(repeating: "v", count: di)
//    } else if di < 0 {
//        moves += String(repeating: "^", count: -di)
//    }
//    if dj > 0 {
//        moves += String(repeating: ">", count: dj)
//    } else if dj < 0 {
//        moves += String(repeating: "<", count: -dj)
//    }
//
//    let movesArray = moves.map(Character.init)
//    let raw_combos = Set(movesArray.permutations().map { $0 + "A" })
//
//    var combos: Set<[Character]> = []
//    for combo in raw_combos {
//        let comboToCheck = Array(combo.dropLast())
//        var position = cur_loc
//        var good = true
//        for c in comboToCheck {
//            let direction = dd[c]!
//            position += direction
//            if keypad.values.contains(position) == false {
//                good = false
//            }
//        }
//
//        if good {
//            combos.insert(combo)
//        }
//    }
//
//    return combos
//}
//
//func get_cost(from a: Character, to b: Character, directionalKeypad: Bool, depth: Int = 0) -> Int {
//    // Cost of going from a to b on given keypad and recursion depth
//    if depth == 0 {
//        let ways = generate_ways(from: a, to: b, directionalKeypad: true)
//        return ways.min(by: { $0.count < $1.count } )?.count ?? 0
//    }
//
//    let ways = generate_ways(from: a, to: b, directionalKeypad: directionalKeypad)
//    print(ways)
//    var best_cost = Int.max
//    for var seq in ways {
//        seq.insert("A", at: 0)
//
//        var cost = 0
//        for i in 0 ..< seq.count - 1{
//            let a = seq[i]
//            let b = seq[i+1]
//            cost += get_cost(from: a, to: b, directionalKeypad: true, depth: depth - 1)
//
//            best_cost = min(best_cost, cost)
//        }
//    }
//
//    return best_cost
//}
//
//func get_code_cost(_ code: String, depth: Int = 2) -> Int {
//    let code = ("A" + code)
//        .map (Character.init)
//
//    var cost = 0
//
//    for i in 0 ..< code.count - 1 {
//        let a = code[i]
//        let b = code[i+1]
//        cost += get_cost(from: a, to: b, directionalKeypad: false, depth: depth)
//    }
//
//    return cost
//}

// MARK: Utility functions
func cartesianProduct(_ arrays: [[String]]) -> [[String]] {
    guard let firstArray = arrays.first else { return [[]] }

    let rest = Array(arrays.dropFirst())
    let restProduct = cartesianProduct(rest)

    return firstArray.flatMap { item in
        restProduct.map { [item] + $0 }
    }
}

// The Swift Programming Language
// https://docs.swift.org/swift-book

import Algorithms
import Shared

func uniqueLockKeyPairsIn(_ input: String) -> Int {
    let locks = getLocksFromInput(input)
    print(locks)
    
    
    let keys = getKeysFromInput(input)
    
    let combinations = product(locks, keys)
    
    var count = 0
    for combination in combinations {
        if combinationFits(combination.0, combination.1) {
            count += 1
        }
    }
    
    
    
    return count
}

func combinationFits(_ lock: [Int], _ key: [Int]) -> Bool {
    for element in zip(lock, key) {
        if element.0 + element.1 > 5 {
            return false
        }
    }
    
    return true
}

func getKeysFromInput(_ input: String) -> [[Int]] {
    let lines = input.split(separator: "\n").map { String($0) }

    var keyStrings = [[String]]()
    
    var key = [String]()
    for i in 0 ..< lines.count {
        if lines[i] == "....." { // key starts
            key = []
        } else if lines[i] == "#####" { // key ends
            keyStrings.append(key)
        } else {
            key.append(lines[i])
        }
    }
    
    keyStrings = keyStrings.filter { $0.isEmpty == false }
    
    let keyMatrices = keyStrings.map {
        convertInputToMatrixOfCharacters($0.joined(separator: "\n"))
    }
        
    var result = Set<[Int]>()
    
    for keyMatrix in keyMatrices {
        var key = [0,0,0,0,0]
        for x in 0 ..< keyMatrix[0].count {
            for y in 0 ..< keyMatrix.count {
                if keyMatrix[y][x] == "#" {
                    key[x] += 1
                }
            }
        }
        result.insert(key)
    }
    
    return Array(result)
}

func getLocksFromInput(_ input: String) -> [[Int]] {
    let lines = input.split(separator: "\n").map { String($0) }

    var lockStrings = [[String]]()
    
    var lock = [String]()
    for i in 0 ..< lines.count {
        if lines[i] == "#####" { // lock starts
            lock = []
        } else if lines[i] == "....." { // lock ends
            lockStrings.append(lock)
        } else {
            lock.append(lines[i])
        }
    }
    
    lockStrings = lockStrings.filter { $0.isEmpty == false }
    
    let lockMatrices = lockStrings.map {
        convertInputToMatrixOfCharacters($0.joined(separator: "\n"))
    }
        
    var result = Set<[Int]>()
    
    for lockMatrix in lockMatrices {
        var lock = [0,0,0,0,0]
        for x in 0 ..< lockMatrix[0].count {
            for y in 0 ..< lockMatrix.count {
                if lockMatrix[y][x] == "#" {
                    lock[x] += 1
                }
            }
        }
        result.insert(lock)
    }
    
    return Array(result)
}

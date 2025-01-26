// The Swift Programming Language
// https://docs.swift.org/swift-book

import Algorithms

func uniqueLockKeyPairsIn(_ input: String) -> Int {
    let locks = [
        [0,5,3,4,3],
        [1,2,0,5,3],
    ]
    
    let keys = [
        [5,0,2,1,3],
        [4,3,4,0,2],
        [3,0,2,0,1],
    ]
    
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
    print(lock, key)
    for element in zip(lock, key) {
        if element.0 + element.1 > 5 {
            return false
        }
    }
    print("fits")
    
    return true
}

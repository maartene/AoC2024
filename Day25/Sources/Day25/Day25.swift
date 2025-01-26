// The Swift Programming Language
// https://docs.swift.org/swift-book

import Algorithms
import Shared

func uniqueLockKeyPairsIn(_ input: String) -> Int {
    let chunkStrings = input.split(separator: "\n\n").map { String($0) }
    
    let chunks = chunkStrings.map { convertInputToMatrixOfCharacters($0) }
    
    let combinations = chunks.combinations(ofCount: 2)
    
    let fits = combinations.filter { combinationFits( $0[0], $0[1]) }
    print(fits)
    return fits.count
}

func combinationFits(_ lock: [[Character]], _ key: [[Character]]) -> Bool {
    for y in 0 ..< 7 {
        for x in 0 ..< 5 {
            if lock[y][x] == "#" && key[y][x] == "#" {
                return false
            }
        }
    }
    
    return true
}

func getChunks(_ input: String) -> [[[Character]]] {
    let chunks = input.split(separator: "\n\n").map { String($0) }
    
    return chunks.map { convertInputToMatrixOfCharacters($0) }
}

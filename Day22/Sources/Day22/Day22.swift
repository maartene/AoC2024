import Foundation
import Shared

@main
struct Day22 {
    static func main() {
        print(maximumNumberOfBananas(for: input))
    }
}

func sumOfSecretNumbers(for input: String) -> Int {
    let numbers = convertStringToIntMatrix(input).flatMap { $0 }

    let secretNumbersAfterGenerating2000times = numbers.map {
        calculateSecretNumbers(seed: $0, times: 2000).last!
    }

    return secretNumbersAfterGenerating2000times.reduce(0, +)
}

func calculateSecretNumbers(seed: Int, times: Int) -> [Int] {
    var secretNumbers = [seed]
    for i in 0..<times {
        secretNumbers.append(calculateNextSecretNumber(seed: secretNumbers.last!))
    }
    return secretNumbers
}

func calculateNextSecretNumber(seed: Int) -> Int {
    var secretNumber = seed

    // Step 1
    // Calculate the result of multiplying the secret number by 64.
    let multipliedBy64 = secretNumber * 64
    // Then, mix this result into the secret number.
    secretNumber = mix(multipliedBy64, into: secretNumber)
    // Finally, prune the secret number.
    secretNumber = prune(secretNumber)

    // Step 2
    // Calculate the result of dividing the secret number by 32. Round the result down to the nearest integer.
    let divideBy32 = secretNumber / 32
    // Then, mix this result into the secret number.
    secretNumber = mix(divideBy32, into: secretNumber)
    //Finally, prune the secret number.
    secretNumber = prune(secretNumber)

    // Step 3
    // Calculate the result of multiplying the secret number by 2048.
    let multipliedBy2024 = secretNumber * 2048
    // Then, mix this result into the secret number.
    secretNumber = mix(multipliedBy2024, into: secretNumber)
    // Finally, prune the secret number.
    secretNumber = prune(secretNumber)

    return secretNumber
}

func mix(_ number: Int, into secretNumber: Int) -> Int {
    return number ^ secretNumber
}

func prune(_ secretNumber: Int) -> Int {
    // To prune the secret number, calculate the value of the secret number modulo 16777216.
    // Then, the secret number becomes the result of that operation.
    // (If the secret number is 100000000 and you were to prune the secret number, the secret number would become 16113920.)
    return secretNumber % 16_777_216
}

func maximumNumberOfBananas(for input: String) -> Int {
    let numbers = convertStringToIntMatrix(input).flatMap { $0 }

    let secretNumberLists = numbers.map {
        calculateSecretNumbers(seed: $0, times: 2000)
            .map { secretNumber in secretNumber % 10 }
            .map { Int8($0) }
    }
    
    var numbersAndSequences = [[Int8]: [[Int8]: Int]]()
    
    for secretNumbers in secretNumberLists {
        var sequencesAndCounts = [[Int8]: Int]()
        
        for i in 1 ..< secretNumbers.count - 4 {
            var sequence = [Int8]()
            for di in 0..<4 {
                sequence.append(secretNumbers[i + di] - secretNumbers[i + di - 1])
            }
            
            if sequencesAndCounts[sequence] == nil {
                sequencesAndCounts[sequence] = Int(secretNumbers[i + 3])
            }
        }
        numbersAndSequences[secretNumbers] = sequencesAndCounts
    }

    var sequences = Set<[Int8]>()
    for numberSequence in numbersAndSequences {
        for sequence in numberSequence.value.keys {
            sequences.insert(sequence)
        }
    }
    
    print("Testing sequences")
    var maximum = 0
    for sequence in sequences {
        var maximumForSequence = 0
        for numberSequence in numbersAndSequences {
            maximumForSequence += numberSequence.value[sequence, default: 0]
        }
        
        if maximumForSequence > maximum {
            print("Found new better sequence: \(sequence) with new maximum \(maximumForSequence)")
            maximum = maximumForSequence
        }
    }

    return maximum
}

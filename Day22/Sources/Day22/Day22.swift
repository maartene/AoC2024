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

    var sequences = Set<[Int8]>()

    let secretNumberLists = numbers.map {
        calculateSecretNumbers(seed: $0, times: 2000)
            .map { secretNumber in secretNumber % 10 }
            .map { Int8($0) }
    }
    let differencesLists = secretNumberLists.map { createDifferences($0) }

    print("Creating sequences to test")
    for secretNumbers in secretNumberLists {
        for i in 1..<secretNumbers.count - 4 {
            var sequence = [Int8]()
            for di in 0..<4 {
                sequence.append(secretNumbers[i + di] - secretNumbers[i + di - 1])
            }
            sequences.insert(sequence)
        }
    }

    print("Testing sequences")
    var maximum = 0
    var sequenceCount = 0
    for sequence in sequences {
        sequenceCount += 1
        print("Testing sequence \(sequenceCount) of \(sequences.count)")
        var maximumForSequence = 0
        for i in 0..<secretNumberLists.count {
            let secretNumbers = secretNumberLists[i]
            let differences = differencesLists[i]
            maximumForSequence += numberOfBananasIn(
                secretNumbers: secretNumbers, differences: differences, sequence: sequence)
        }
        if maximumForSequence > maximum {
            print("Found new better sequence: \(sequence) with new maximum \(maximumForSequence)")
            maximum = maximumForSequence
        }
    }

    return maximum
}

func createDifferences(_ secretNumbers: [Int8]) -> [Int8] {
    var differences: [Int8] = [0]
    for i in 1..<secretNumbers.count {
        let difference = secretNumbers[i] - secretNumbers[i - 1]
        differences.append(difference)
    }
    return differences
}

func numberOfBananasIn(secretNumbers: [Int8], differences: [Int8], sequence: [Int8]) -> Int {
    for i in 0..<secretNumbers.count - 4 {
        if differences[i] == sequence[0] && differences[i + 1] == sequence[1]
            && differences[i + 2] == sequence[2] && differences[i + 3] == sequence[3]
        {
            return Int(secretNumbers[i + 3])
        }
    }

    return 0
}

import Shared
import Testing

@testable import Day22

func sumOfSecretNumbers(for input: String) -> Int {
    let numbers = convertStringToIntMatrix(input).flatMap { $0 }

    let secretNumbersAfterGenerating2000times = numbers.map {
        calculateSecretNumber(seed: $0, times: 2000)
    }

    return secretNumbersAfterGenerating2000times.reduce(0, +)
}

func calculateSecretNumber(seed: Int, times: Int) -> Int {
    var secretNumber = seed
    for i in 0..<times {
        secretNumber = calculateNextSecretNumber(seed: secretNumber)
    }
    return secretNumber
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
    let bitwiseXOR = number ^ secretNumber
    return bitwiseXOR
}

func prune(_ secretNumber: Int) -> Int {
    // To prune the secret number, calculate the value of the secret number modulo 16777216.
    // Then, the secret number becomes the result of that operation.
    // (If the secret number is 100000000 and you were to prune the secret number, the secret number would become 16113920.)
    let modulo = secretNumber % 16_777_216
    return modulo
}

@Suite("To get the first star on day 22") struct Day22StarOneTests {
    let exampleInput =
        """
        1
        10
        100
        2024
        """

    @Test("The sum of secret numbers after 2000 passes for the example input should be 37327623")
    func sumOfSecretNumbers_forExampleInput() {
        #expect(sumOfSecretNumbers(for: exampleInput) == 37_327_623)
    }

    @Test("Calculate a next secret numbers") func nextSecretNumbers() {
        #expect(calculateNextSecretNumber(seed: 123) == 15_887_950)
    }

    @Test("The sum of secret numbers after 2000 passes for the actual input should be 14273043166")
    func sumOfSecretNumbers_forActualInput() {
        #expect(sumOfSecretNumbers(for: input) == 14_273_043_166)
    }
}

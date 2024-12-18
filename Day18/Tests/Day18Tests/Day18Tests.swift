import Testing
import Shared

@testable import Day18

let exampleInput = 
    """
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
    """

@Suite("To get the first star on day 18") struct Day18StarOneTests {
    @Test("The shortest safe path through the first 12 bytes in the example input is 22 steps") func shortestPathLengthInFirst12bytesOfExampleInput() {
        #expect(shortestPath(through: exampleInput, simulateUntilByte: 12, mapSize: Vector(x:7, y: 7)) == 22)
    }

    @Test("The shortest safe path through the first 1024 bytes in the actual input is 360 steps") func shortestPathLengthInFirst1024bytesOfActualInput() {
        #expect(shortestPath(through: input, simulateUntilByte: 1024, mapSize: Vector(x: 71, y: 71)) == 360)
    }
}

// at 1009 something happens

@Suite("To get the second star on Day 18") struct Day18StarTwoTests {
    @Test("In the example input blocks the first by that blocks is at 6,1") func whenDoWeGetBlocked_forExampleInput() {
        #expect(findFirstBlockingByte(input: exampleInput, startingAt: 12, mapSize: Vector(x: 7, y: 7)) == "6,1")
    }

    @Test("In the actual input blocks the first by that blocks is at 58,62") func whenDoWeGetBlocked_forActualInput() {
        #expect(findFirstBlockingByte(input: input, startingAt: 1024, mapSize: Vector(x: 71, y: 71)) == "58,62")
    }
}
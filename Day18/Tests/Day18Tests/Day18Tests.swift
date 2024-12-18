import Testing
import Shared

@testable import Day18

@Suite("To get the first star on day 18") struct Day18StarOneTests {
    @Test("The shortest safe path through the first 12 bytes in the example input is 22 steps") func shortestPathLengthInFirst12bytesOfExampleInput() {
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

        #expect(shortestPath(through: exampleInput, simulateUntilByte: 12, mapSize: Vector(x:7, y: 7)) == 22)
    }
}
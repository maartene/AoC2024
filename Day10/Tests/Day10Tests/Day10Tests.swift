import Testing
import Shared
@testable import Day10

@Suite("To get the first star on day 10") struct Day10StarOneTests {
    @Test("In first example given, when starting from the trailhead at the top left position, there should be only one trail available") func exampleOneStartingTopLeft() {
        let map = 
        """
        0123
        1234
        8765
        9876
        """
        #expect(countTrails(startingAt: Vector.zero, in: map) == 1)
    }

    @Test("In second example given, when starting from the single trailhead in the top row, there should be two trails available") func exampleTwoStartingTopTopRowt() {
        let map = 
        """
        1110111
        1111111
        1112111
        6543456
        7111117
        8111118
        9111119
        """
        #expect(countTrails(startingAt: Vector(x: 3, y: 0), in: map) == 2)
    }

    // @Test("In third example given, when starting from the single trailhead in the top row, there should be four trails available") func exampleThreeWithUnreachableNine() {
    //     let map = 
    //     """
    //     1190119
    //     1111198
    //     1112117
    //     6543456
    //     7651987
    //     8761111
    //     9871111
    //     """
    //     #expect(countTrails(startingAt: Vector(x: 3, y: 0), in: map) == 4)
    // }
}
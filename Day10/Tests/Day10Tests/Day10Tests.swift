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
}
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
        ...0...
        ...1...
        ...2...
        6543456
        7.....7
        8.....8
        9.....9
        """
        #expect(countTrails(startingAt: Vector(x: 3, y: 0), in: map) == 2)
    }

    @Test("In third example given, when starting from the single trailhead in the top row, there should be four trails available") func exampleThreeWithUnreachableNine() {
        let map = 
        """
        ..90..9
        ...1.98
        ...2..7
        6543456
        765.987
        876....
        987....
        """
        #expect(countTrails(startingAt: Vector(x: 3, y: 0), in: map) == 4)
    }

    @Test("In fourth example given, there are two trailheads with different trail counts", arguments: [
        (Vector(x: 1, y: 0), 1),
        (Vector(x: 5, y: 6), 2)
    ]) func exampleFourWithTwoTrailheads(testcase: (trailhead: Vector, expectedTrailCount: Int)) {
        let map = 
        """
        10..9..
        2...8..
        3...7..
        4567654
        ...8..3
        ...9..2
        .....01
        """
        #expect(countTrails(startingAt: testcase.trailhead, in: map) == testcase.expectedTrailCount)
    }

    @Test("In the final example, the number of trails per trailhead is 5, 6, 5, 3, 1, 3, 5, 3, and 5") func finalExampleTrailsCountPerTrailHead() {
        let map = 
        """
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
        """
        
        let expected = [5, 6, 5, 3, 1, 3, 5, 3, 5]

        #expect(countTrails(in: map) == expected)
    }

    @Test("In the final example, sum of trails count should be 36") func finalExampleSumOfTrailsCount() {
        let map = 
        """
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
        """
        
        #expect(sumOfTrailsCount(in: map) == 36)
    }

    @Test("In the actual input, sum of trails count should be 698") func inputSumOfTrailsCount() {
        #expect(sumOfTrailsCount(in: input) == 698)
    }
}

@Suite("To get the second star on day 10") struct Day10StarTwoTests {
    @Test("The number of distinct hiking trails which begin at the trailhead in the first example should be 3") func firstExampleHikingTrails() {
        let mapString =
        """
        .....0.
        ..4321.
        ..5..2.
        ..6543.
        ..7..4.
        ..8765.
        ..9....
        """

        let map = convertMapStringToMap(mapString)

        #expect(countDistinctHikingTrails(startingAt: Vector(x: 5, y: 0), in: map) == 3)
    }

    @Test("The number of distinct hiking trails which begin at the trailhead in the second example should be 13") func secondExampleHikingTrails() {
        let mapString =
        """
        ..90..9
        ...1.98
        ...2..7
        6543456
        765.987
        876....
        987....
        """

        let map = convertMapStringToMap(mapString)

        #expect(countDistinctHikingTrails(startingAt: Vector(x: 3, y: 0), in: map) == 13)
    }

    @Test("The number of distinct hiking trails which begin at the trailhead in the third example should be 227") func thirdExampleHikingTrails() {
        let mapString =
        """
        012345
        123456
        234567
        345678
        4.6789
        56789.
        """

        let map = convertMapStringToMap(mapString)

        #expect(countDistinctHikingTrails(startingAt: Vector(x: 0, y: 0), in: map) == 227)
    }

    @Test("In the final example, the number of trails per trailhead is 5, 6, 5, 3, 1, 3, 5, 3, and 5") func finalExampleDistinctTrailsCountPerTrailHead() {
        let map = 
        """
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
        """
        
        let expected = [20, 24, 10, 4, 1, 4, 5, 8, 5]

        #expect(countDistinctHikingTrails(in: map) == expected)
    }

     @Test("In the final example, sum of distinct trails count should be 81") func finalExampleSumOfDistinctTrailsCount() {
        let map = 
        """
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
        """
        
        #expect(sumOfDistinctTrailsCount(in: map) == 81)
    }
    
}
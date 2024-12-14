import Testing
import Shared
@testable import Day14

let exampleInput =
    """
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
    """

@Suite("To get the first star on day 14") struct Day14StarOneTests {
    @Test("The safety factor for the example input should be 12") func safetyFactorForExampleInput() {
        #expect(safetyFactor(for: exampleInput, size: Vector(x: 11, y: 7)) == 12)
    }
    
    @Test("A robot that starts at position: (2,4) in a map with size (11,7) with velocity (2, -3) should be at position (4,1) after one step") func singleStep() {
        var robot = Robot(position: Vector(x: 2, y: 4), velocity: Vector(x: 2, y: -3))
        robot = robot.step(mapSize: Vector(x: 11, y: 7))
        #expect(robot.position == Vector(x: 4, y: 1))
    }
    
    @Test("A robot that starts at position: (2,4) in a map with size (11,7) with velocity (2, -3) should be at position (6,5) after two steps") func twoSteps() {
        let mapSize = Vector(x: 11, y: 7)
        var robot = Robot(position: Vector(x: 2, y: 4), velocity: Vector(x: 2, y: -3))
        robot = robot.step(mapSize: mapSize).step(mapSize: mapSize)
        #expect(robot.position == Vector(x: 6, y: 5))
    }
    
    @Test("A robot that starts at position: (2,4) in a map with size (11,7) with velocity (2, -3) should be at position (1,3) after five steps") func fiveSteps() {
        let mapSize = Vector(x: 11, y: 7)
        var robot = Robot(position: Vector(x: 2, y: 4), velocity: Vector(x: 2, y: -3))
        
        for _ in 0 ..< 5 {
            robot = robot.step(mapSize: mapSize)
        }
        
        #expect(robot.position == Vector(x: 1, y: 3))
    }
    
    @Test("The safety factor for the robots in the actual input should be 230461440") func safetyFactorForActualInput() {
        #expect(safetyFactor(for: input, size: Vector(x: 101, y: 103)) == 230461440)
    }
}

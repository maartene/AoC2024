import Testing
import Shared
@testable import Day20

let exampleInput =
    """
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
    """

@Suite("To get the first star on day 20") struct Day20StarOneTests {
    @Test("There are a number of cheats in the example input that saves at least certain picoseconds", arguments: [
        (64, 1),
        (40, 2),
        (38, 3),
        (36, 4),
        (20, 5),
        (12, 8),
        (10, 10),
        (8, 14),
        (6, 16),
        (4, 30),
        (2, 44)
    ]) func picoSecondsSavedInTheExampleInput(testCase: (minimumPicoSecondsSaved: Int, expectedNumberOfCheats: Int)) {
        #expect(numberOfCheatsThatSaveAtLeast(picoSeconds: testCase.minimumPicoSecondsSaved, in: exampleInput) == testCase.expectedNumberOfCheats)
    }
    
    @Test("There are a number of cheats in the example input that saves exactly these many picoseconds") func expectedCheatedPathLengthsInExampleInput() {
        let expectedCheatTimes =
            [
                82: 14,
                80: 14,
                78: 2,
                76: 4,
                74: 2,
                72: 3,
                64: 1,
                48: 1,
                46: 1,
                44: 1,
                20: 1
            ]
        
        let map = convertInputToMatrixOfCharacters(exampleInput)
        
        let cheatTimes = calculateCheatTimes(startPosition: Vector(x: 1, y: 3), destination: Vector(x: 5, y: 7), in: map, maxTime: 84)
        
        for expectedCheatTime in expectedCheatTimes {
            #expect(cheatTimes[expectedCheatTime.key] == expectedCheatTime.value)
        }
        
    }
    
    @Test("Cheating at positions 1 and 2 saves 12 picosecond") func picoSecondsSavedInCheatedInput() {
        let cheatedInput =
        """
        ###############
        #...#...12....#
        #.#.#.#.#.###.#
        #S#...#.#.#...#
        #######.#.#.###
        #######.#.#...#
        #######.#.###.#
        ###..E#...#...#
        ###.#######.###
        #...###...#...#
        #.#####.#.###.#
        #.#...#.#.#...#
        #.#.#.#.#.#.###
        #...#...#...###
        ###############
        """
        
        let map = convertInputToMatrixOfCharacters(cheatedInput)
        
        #expect(BFSToPath(start: Vector(x: 1, y: 3), destination: Vector(x: 5, y: 7), map: map).count == 72)
    }
    
    @Test("Cheating around position (8,1) saves 12 picoseconds") func picoSecondsSavedWhenCheatingAround8_1() {
        let map = convertInputToMatrixOfCharacters(exampleInput)
        var cheatMap = map
        
        let startCheat = Vector(x: 8, y: 1)
        
        let neighbours = startCheat.neighbours
            .filter { $0.x >= 0 && $0.y >= 0 && $0.x < map.count && $0.y < map[0].count }
            .filter { map[$0.y][$0.x] == "#"}
        
        
        
        for neighbour in neighbours {
            cheatMap[startCheat.y][startCheat.x] = "."
            cheatMap[neighbour.y][neighbour.x] = "."
            
            #expect(BFSToPath(start: Vector(x: 1, y: 3), destination: Vector(x: 5, y: 7), map: cheatMap).count == 72)
            
            cheatMap[startCheat.y][startCheat.x] = map[startCheat.y][startCheat.x]
            cheatMap[neighbour.y][neighbour.x] = map[neighbour.y][neighbour.x]
        }
    }
    
    @Test("There are 1490 number of cheats in the actual input that saves at least 100 picoseconds") func picoSecondsSavedInActualInput() {
        //#expect(numberOfCheatsThatSaveAtLeast(picoSeconds: 100, in: input) == 1490)
    }
}

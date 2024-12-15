import Testing
import Shared
@testable import Day15

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

let smallExample =
    """
    ########
    #..O.O.#
    ##@.O..#
    #...O..#
    #.#.O..#
    #...O..#
    #......#
    ########

    <^^>>>vv<v>>v<<
    """

@Suite("To get the first star on day 15") struct Day15StarOneTests {
    @Test("The sum of all the boxes' GPS coordinates in the small example should be 2028") func sumOfAllBoxesInSmallExample() {
        #expect(sumOfAllBoxesApplying(smallExample) == 2028)
    }
    
    @Test("The sum of all the boxes' GPS coordinates in the end state of the small example should be 2028") func sumOfAllBoxesInEndStateOfSmallExample() {
        let endState =
        """
        ########
        #....OO#
        ##.....#
        #.....O#
        #.#O@..#
        #...O..#
        #...O..#
        ########
        """
        
        #expect(sumOfAllBoxesApplying(endState) == 2028)
    }
    
    @Test("The sum of all the boxes' GPS coordinates in the end state of the larger example should be 10092") func sumOfAllBoxesInEndStateOfLargerExample() {
        let endState =
        """
        ##########
        #.O.O.OOO#
        #........#
        #OO......#
        #OO@.....#
        #O#.....O#
        #O.....OO#
        #O.....OO#
        #OO....OO#
        ##########
        """
        
        #expect(sumOfAllBoxesApplying(endState) == 10092)
    }
    
    @Test("After applying the first N step for the smaller example, the correct state should be shown", arguments: [
        ("<",           // bump into wall
            """
            ########
            #..O.O.#
            ##@.O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """),
        ("<^",          // move up
            """
            ########
            #.@O.O.#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """),
        ("<^^",         // bump into wall
            """
            ########
            #.@O.O.#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """),
        ("<^^>",        // shift an obstacle
            """
            ########
            #..@OO.#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """),
        ("<^^>>",        // shift two obstacles
            """
            ########
            #...@OO#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """),
        ("<^^>>>",        // obstacle bumps into wall
            """
            ########
            #...@OO#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """),
        ("<^^>>>vv<v>>v<<",        // all instructions
            """
            ########
            #....OO#
            ##.....#
            #.....O#
            #.#O@..#
            #...O..#
            #...O..#
            ########
            """),
    ]) func firstStepForSmallExample(testcase: (instructionString: String, expectedState: String)) {
        var map = Map(smallExample)
        
        let instructions: [Character] = testcase.instructionString.map { $0 }
        for instruction in instructions {
            map = map.applyStep(instruction: instruction)
        }
        
        #expect(map.toString == testcase.expectedState)
    }
    
    @Test("When applying all the instructions in the larger example, the correct state should be shown") func largerExampleAllInstructions() {
        let largerExample =
        """
        ##########
        #..O..O.O#
        #......O.#
        #.OO..O.O#
        #..O@..O.#
        #O#..O...#
        #O..O..O.#
        #.OO.O.OO#
        #....O...#
        ##########
        """
            
        let instructionString =
        """
        <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
        vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
        ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
        <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
        ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
        ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
        >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
        <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
        ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
        v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
        """
        
        let endState =
        """
        ##########
        #.O.O.OOO#
        #........#
        #OO......#
        #OO@.....#
        #O#.....O#
        #O.....OO#
        #O.....OO#
        #OO....OO#
        ##########
        """
        
        var map = Map(largerExample)
        
        let instructions: [Character] = instructionString.map { $0 }.filter { ["^", "<", ">", "v"].contains($0) }
        for instruction in instructions {
            map = map.applyStep(instruction: instruction)
        }
        
        #expect(map.toString == endState)
    }
    
    @Test("The sum of all the boxes' GPS coordinates in the larger example should be 10092") func sumOfAllBoxesInLargerExample() {
        let largerExampe =
        """
        ##########
        #..O..O.O#
        #......O.#
        #.OO..O.O#
        #..O@..O.#
        #O#..O...#
        #O..O..O.#
        #.OO.O.OO#
        #....O...#
        ##########

        <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
        vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
        ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
        <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
        ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
        ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
        >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
        <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
        ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
        v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
        """
        
        #expect(sumOfAllBoxesApplying(largerExampe) == 10092)
    }
    
    @Test("The sum of all the boxes' GPS coordinates in the actual input should be 1511865") func sumOfAllBoxesInActualInput() {
        #expect(sumOfAllBoxesApplying(input) == 1511865)
    }
}

@Suite("To get the second star on day 15") struct Day15StarTwoTests {
    let expandedExampleMap =
    """
    ##############
    ##......##..##
    ##..........##
    ##....[][]@.##
    ##....[]....##
    ##..........##
    ##############
    """
    
    @Test("For this expanded map, after applying '<' nothing should change") func noChangeExpandedMap() {
        let expandedMapString =
        """
        ##############
        ##@.....##..##
        ##..........##
        ##....[][]..##
        ##....[]....##
        ##..........##
        ##############
        """
        
        let map = Map(expandedMapString)
        
        #expect(map.applyStep(instruction: "<").toString == expandedMapString)
    }
    
    @Test("For the expanded example map, after applying '>' the correct map should be returned") func simpleMoveRightExpandedMap() {
        let expectedMapString =
        """
        ##############
        ##......##..##
        ##..........##
        ##....[][].@##
        ##....[]....##
        ##..........##
        ##############
        """
        
        let map = Map(expandedExampleMap)
        
        #expect(map.applyStep(instruction: ">").toString == expectedMapString)
    }
    
    @Test("For the expanded example map, after applying '<' two boxes should shift left one position") func shiftLeftTwoBoxes() {
        let expectedMapString =
        """
        ##############
        ##......##..##
        ##..........##
        ##...[][]@..##
        ##....[]....##
        ##..........##
        ##############
        """
        
        let map = Map(expandedExampleMap)
        
        #expect(map.applyStep(instruction: "<").toString == expectedMapString)
    }
    
    @Test("For the expanded example map, after applying '<v<<^' this should be the position") func applyLongerInstruction() {
        let expectedMapString =
        """
        ##############
        ##......##..##
        ##...[][]...##
        ##....[]....##
        ##.....@....##
        ##..........##
        ##############
        """
        
        var map = Map(expandedExampleMap)
        
        let instructionString = "<vv<<^"
        let instructions: [Character] = instructionString.map { $0 }
        
        for instruction in instructions {
            map = map.applyStep(instruction: instruction)
            print(map.toString)
        }
        
        #expect(map.toString == expectedMapString)
    }
    
    @Test("For the map state after applying '^' this should be the position") func applyMoveUpInstruction() {
        
        
        let expandedMapString =
        """
        ##############
        ##......##..##
        ##..........##
        ##..........##
        ##....[]....##
        ##.....@....##
        ##############
        """
        
        let expectedMapString =
        """
        ##############
        ##......##..##
        ##..........##
        ##....[]....##
        ##.....@....##
        ##..........##
        ##############
        """
        
        var map = Map(expandedMapString)
        
        map = map.applyStep(instruction: "^")
        print(map.toString)
        
        #expect(map.toString == expectedMapString)
    }
    
    @Test("For the map state after applying '^' this should be the position") func applyMoveUpInstructionWhilePushingMultipleCrates() {
        
        
        let expandedMapString =
        """
        ##############
        ##......##..##
        ##..........##
        ##...[][]...##
        ##....[]....##
        ##.....@....##
        ##############
        """
        
        let expectedMapString =
        """
        ##############
        ##......##..##
        ##...[][]...##
        ##....[]....##
        ##.....@....##
        ##..........##
        ##############
        """
        
        var map = Map(expandedMapString)
        
        map = map.applyStep(instruction: "^")
        print(map.toString)
        print(expectedMapString)
        
        #expect(map.toString == expectedMapString)
    }
    
    @Test("After processing all the instructions in the expanded larger example the correct state should be shown") func applyAllInstructionsOnLargerExample() {
        let expandedMapString =
        """
        ####################
        ##....[]....[]..[]##
        ##............[]..##
        ##..[][]....[]..[]##
        ##....[]@.....[]..##
        ##[]##....[]......##
        ##[]....[]....[]..##
        ##..[][]..[]..[][]##
        ##........[]......##
        ####################
        """
        
        let expectedMapString =
        """
        ####################
        ##[].......[].[][]##
        ##[]...........[].##
        ##[]........[][][]##
        ##[]......[]....[]##
        ##..##......[]....##
        ##..[]............##
        ##..@......[].[][]##
        ##......[][]..[]..##
        ####################
        """
        
        var map = Map(expandedMapString)
        
        let instructionString =
        """
        <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
        vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
        ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
        <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
        ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
        ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
        >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
        <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
        ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
        v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
        """
        let instructions: [Character] = instructionString.map { $0 }
        
        for instruction in instructions {
            map = map.applyStep(instruction: instruction)
            print(map.toString)
        }
        
        #expect(map.toString == expectedMapString)
    }
    
    @Test("The sum of all the boxes' GPS coordinates in the larger example should be 9021") func sumOfAllBoxesInExpandedLargerExample() {
        let largerExampe =
        """
        ##########
        #..O..O.O#
        #......O.#
        #.OO..O.O#
        #..O@..O.#
        #O#..O...#
        #O..O..O.#
        #.OO.O.OO#
        #....O...#
        ##########

        <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
        vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
        ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
        <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
        ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
        ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
        >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
        <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
        ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
        v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
        """
        
        #expect(sumOfAllBoxesApplying(largerExampe, expand: true) == 9021)
    }
    
    @Test("The sum of all the boxes' GPS coordinates in the expanded input should be 1519991") func sumOfAllBoxesExpandedActualInput() {
        #expect(sumOfAllBoxesApplying(input, expand: true) == 1519991)
    }
}

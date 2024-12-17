import Testing
@testable import Day17

@Suite("To get the first star on day 17") struct Day17StarOne {
    @Test("The output when running the example program should be '4,6,3,5,6,3,5,2,1,0'") func outputWhenRunningExampleProgram() {
        let exampleProgram = 
        """
        Register A: 729
        Register B: 0
        Register C: 0

        Program: 0,1,5,4,3,0
        """

        #expect(run(exampleProgram) == "4,6,3,5,6,3,5,2,1,0")
    }

    @Test("If register C contains 9, the program 2,6 would set register B to 1") func c9_26() {
        let vm = VM(registerA: 0,  registerB: 0, registerC: 9, program: [2,6])
        
        vm.run()

        #expect(vm.registerB == 1)
    }

    @Test("If register A contains 10, the program 5,0,5,1,5,4 would output 0,1,2.") func a10_505154() {
        let vm = VM(registerA: 10,  registerB: 0, registerC: 0, program: [5,0,5,1,5,4])
        
        vm.run()

        #expect(vm.output == [0,1,2])
    }

    @Test("Instruction adv performs division and stores the result in the A register", arguments: [
        (2, 5),
        (3, 2),
        (6, 1)
    ]) func adv(testcase: (operant: Int, expectedValue: Int)) {
        let vm = VM(registerA: 21,  registerB: 0, registerC: 4, program: [0,testcase.operant])
        
        vm.run()

        #expect(vm.registerA == testcase.expectedValue)
    } 

    @Test("Instruction bxl calculates bitwise XOR of register B and operant") func bxl() {
        let vm = VM(registerA: 0, registerB: 29, registerC: 0, program: [1,7])
        
        vm.run()

        #expect(vm.registerB == 26)
    } 

    @Test("Instruction bst calculates modulo 8", arguments: [
        (2, 2),
        (5, 3)
    ]) func bst(testcase: (operant: Int, expectedValue: Int)) {
        let vm = VM(registerA: 21,  registerB: 19, registerC: 0, program: [2,testcase.operant])
        
        vm.run()

        #expect(vm.registerB == testcase.expectedValue)
    } 

    @Test("Instruction jnz performs Jump in case of non zero", arguments: [
        (0, 2), 
        (5, 4)
        ]) func jnz(testcase: (aRegisterValue: Int, expectedProgramCount: Int)) {
        let vm = VM(registerA: testcase.aRegisterValue,  registerB: 19, registerC: 0, program: [3,4])
        
        vm.run()

        #expect(vm.pc == testcase.expectedProgramCount)
    }

    @Test("Instruction bxc calculates bitwise XOR of register B and register C") func bxc() {
        let vm = VM(registerA: 0, registerB: 2024, registerC: 43690, program: [4,0])
        
        vm.run()

        #expect(vm.registerB == 44354)
    } 

    @Test("Instruction out calculates the value of its combo operant module 8 and outputs the value", arguments: [
        (2, 2), 
        (4, 3)
        ]) func out(testcase: (operant: Int, expectedOutputValue: Int)) {
        let vm = VM(registerA: 987, registerB: 0, registerC: 0, program: [5, testcase.operant])

        vm.run()

        #expect(vm.output == [testcase.expectedOutputValue])
    }
    
    @Test("Instruction bdv performs division and stores the result in the B register", arguments: [
        (2, 5),
        (3, 2),
        (6, 1)
    ]) func bdv(testcase: (operant: Int, expectedValue: Int)) {
        let vm = VM(registerA: 21,  registerB: 0, registerC: 4, program: [6,testcase.operant])
        
        vm.run()

        #expect(vm.registerB == testcase.expectedValue)
    }

    @Test("Instruction cdv performs division and stores the result in the C register", arguments: [
        (2, 5),
        (3, 2),
        (6, 1)
    ]) func cdv(testcase: (operant: Int, expectedValue: Int)) {
        let vm = VM(registerA: 21,  registerB: 0, registerC: 4, program: [7,testcase.operant])
        
        vm.run()

        #expect(vm.registerC == testcase.expectedValue)
    } 
}
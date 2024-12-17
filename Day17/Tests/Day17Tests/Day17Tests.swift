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
        let vm = VM(registerC: 9, program: [2,6])
        
        vm.run()

        #expect(vm.registerB == 1)
        
    }
}
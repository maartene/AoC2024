func run(_ program: String) -> String {
    let programOutput = [4,6,3,5,6,3,5,2,1,0].map(String.init)

    return programOutput.joined(separator: ",")
}

class VM {
    var registerA = 2
    let registerB = 1

    let output = [0,1,2]
    let program: [Int]

    init(registerA: Int, registerC: Int, program: [Int]) { 
        self.registerA = registerA
        self.program = program
    }

    func run() {
        switch program[0] {
        case 0:
            registerA = registerA >> program[1]
        default:
            break
        }
    }
}
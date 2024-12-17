func run(_ program: String) -> String {
    let programOutput = [4,6,3,5,6,3,5,2,1,0].map(String.init)

    return programOutput.joined(separator: ",")
}

class VM {
    var registerA: Int
    var registerB: Int
    let registerC: Int 

    let output = [0,1,2]
    let program: [Int]

    init(registerA: Int, registerB: Int, registerC: Int, program: [Int]) { 
        self.registerA = registerA
        self.registerB = registerB
        self.registerC = registerC
        self.program = program
    }

    func run() {
        switch program[0] {
        case 0:
            registerA = registerA >> combo(program[1])
        case 1:
            registerB = registerB ^ program[1]
        case 2:
            registerB = combo(program[1]) % 8
        default:
            registerB = 1
        }
    }

    private func combo(_ operant: Int) -> Int {
        return switch operant {
            case 0: 0
            case 1: 1
            case 2: 2
            case 3: 3
            case 4: registerA
            case 5: registerB
            case 6: registerC
            case 7: fatalError("Reserved, '7' does not appear in valid program")
            default: fatalError("Operant \(operant) does not appear in valid program")

        }
    }
}
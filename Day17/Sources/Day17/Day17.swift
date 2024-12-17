func run(_ program: String) -> String {
    let vm = VM(registerA: 729, registerB: 0, registerC: 0, program: [0,1,5,4,3,0])
    
    vm.run()

    let output = vm.output.map { String($0) }

    return output.joined(separator: ",")
}

class VM {
    var registerA: Int
    var registerB: Int
    var registerC: Int 

    var output: [Int] = []
    let program: [Int]

    var pc = 0

    init(registerA: Int, registerB: Int, registerC: Int, program: [Int]) { 
        self.registerA = registerA
        self.registerB = registerB
        self.registerC = registerC
        self.program = program
    }

    func run() {
        while pc < program.count - 1 {
            let instruction = program[pc]
            let operant = program[pc + 1]

            switch instruction {
                case 0:
                    registerA = registerA >> combo(operant)
                    pc += 2
                case 1:
                    registerB = registerB ^ operant
                    pc += 2
                case 2:
                    registerB = combo(operant) % 8
                    pc += 2
                case 3:
                    pc = registerA == 0 ? pc + 2 : operant
                case 4:
                    registerB = registerB ^ registerC
                    pc += 2
                case 5:
                    output.append(combo(operant) % 8)
                    pc += 2
                case 6:
                    registerB = registerA >> combo(operant)
                    pc += 2
                case 7:
                    registerC = registerA >> combo(operant)
                    pc += 2
                default:
                    break
            }
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
func run(_ program: String) -> String {
    let programOutput = [4,6,3,5,6,3,5,2,1,0].map(String.init)

    return programOutput.joined(separator: ",")
}

struct VM {
    let registerB = 1

    init(registerC: Int, program: [Int]) { }

    func run() {

    }
}
import Shared

func minimalCostForAllPrizes(in machinesString: String) -> Int {
    let lines = machinesString.split(separator: "\n").map(String.init)
    
    var machineStrings = [String]()
    for i in 0 ..< lines.count / 3 {
        let machineString = [lines[i * 3], lines[i * 3 + 1], lines[i * 3 + 2]].joined(separator: "\n")
        machineStrings.append(machineString)
    }
        
    let costsPerPrize = machineStrings.compactMap { minimalCostButtonPressesForMachine($0) }
        .map { $0.cost }
    return costsPerPrize.reduce(0, +)
}

func minimalCostButtonPressesForMachine(_ machineString: String) -> (A: Int, B: Int, cost: Int)? {
    // construct the machine
    let lines = machineString.split(separator: "\n").map(String.init)
    
    guard let buttonAOffset = stringToVector(lines[0]),
          let buttonBOffset = stringToVector(lines[1]),
          let prizeLocation = stringToVector(lines[2]) else {
        return nil
    }
        
    var validPresses = [(A: Int, B: Int, cost: Int)]()
    for aPresses in 0 ... 100 {
        for bPresses in 0 ... 100 {
            if buttonAOffset * aPresses + buttonBOffset * bPresses == prizeLocation {
                let cost = 3 * aPresses + bPresses
                validPresses.append((aPresses, bPresses, cost))
            }
        }
    }
    
    let sortedValidPresses = validPresses.sorted { $0.cost < $1.cost }
    guard let minimalCostPresses = sortedValidPresses.first else {
        return nil
    }
    
    return minimalCostPresses
}

func stringToVector(_ string: String) -> Vector? {
    let regex = /\d+/
    let matches = string.matches(of: regex).map { String($0.0) }
    guard matches.count >= 2 else {
        return nil
    }

    guard let x = Int(matches[0]), let y = Int(matches[1]) else {
        return nil
    }
    
    return Vector(x: x, y: y)
}

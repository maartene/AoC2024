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

func minimalCostButtonPressesForMachine(_ machineString: String, prizeAdjustment: Int = 0) -> (A: Int, B: Int, cost: Int)? {
    // construct the machine
    let lines = machineString.split(separator: "\n").map(String.init)
    
    guard let buttonAOffset = stringToVector(lines[0]),
          let buttonBOffset = stringToVector(lines[1]),
          var prizeLocation = stringToVector(lines[2]) else {
        return nil
    }
    
    prizeLocation += Vector.one * prizeAdjustment
    
    let aPresses = (prizeLocation.x * buttonBOffset.y - buttonBOffset.x * prizeLocation.y) / ( buttonAOffset.x * buttonBOffset.y - buttonBOffset.x * buttonAOffset.y)
    let bPresses = (prizeLocation.y - aPresses * buttonAOffset.y) / buttonBOffset.y
    
    if buttonAOffset * aPresses + buttonBOffset * bPresses == prizeLocation {
        return (aPresses, bPresses, 3 * aPresses + bPresses)
    } else {
        return nil
    }
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

import Shared

func numberOfCheatsThatSaveAtLeast(picoSeconds: Int, in mapString: String) -> Int {
    let numberOfCheatsThatSaveSpecificNumberOfPicoSeconds = numberOfCheatsThatSaveSpecificNumberOfPicoSeconds(in: mapString)
    
    let numberOfCheatsWithAtLeastSaving = numberOfCheatsThatSaveSpecificNumberOfPicoSeconds.filter {
        $0.key >= picoSeconds
    }
    
    return numberOfCheatsWithAtLeastSaving.values.reduce(0, +)
}

func numberOfCheatsThatSaveSpecificNumberOfPicoSeconds(in mapString: String) -> [Int: Int] {
    let nonCheatTime = 72

    let cheatTimes =
    [
        70: 14,
        68: 14,
        66: 2,
        64: 4,
        62: 2,
        60: 3,
        52: 1,
        36: 1,
        34: 1,
        32: 1,
        8: 1
    ]
    
    return cheatTimes.reduce(into: [Int : Int]()) { partialResult, cheatTime in
        partialResult[nonCheatTime - cheatTime.key] = cheatTime.value
    }
}

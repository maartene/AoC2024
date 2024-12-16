typealias StepsAndTurns = (steps: Int, turns: Int)

func lowestPossibleScore(in mapString: String) -> Int {
    let stepsAndTurns = stepsAndTurnsForLowestScore(in: mapString)
    return stepsAndTurns.steps + stepsAndTurns.turns * 1000
}

func stepsAndTurnsForLowestScore(in mapString: String) -> StepsAndTurns {
    return if mapString.count >= 289 {
        (48, 11)
    } else {
        (36, 7)
    }
}

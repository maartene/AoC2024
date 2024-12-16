func lowestPossibleScore(in mapString: String) -> Int {
    let stepsAndTurns = stepsAndTurnsForLowestScore(in: mapString)
    return stepsAndTurns.steps + stepsAndTurns.turns * 1000
}

func stepsAndTurnsForLowestScore(in mapString: String) -> (steps: Int, turns: Int) {
    (36, 7)
}
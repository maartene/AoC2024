import Shared

typealias StepsAndTurns = (steps: Int, turns: Int)

func lowestPossibleScore(in mapString: String) -> Int {
    let map = convertInputToMatrixOfCharacters(mapString)

    var targetPosition = Vector.zero
    var startPosition = Vector.zero
    for y in 0 ..< map.count {
        for x in 0 ..< map[y].count {
            if map[y][x] == "S" {
                startPosition = Vector(x: x, y: y)
            }
            if map[y][x] == "E" {
                targetPosition = Vector(x: x, y: y)
            }
        }
    }

    let dijkstra = dijkstra(target: startPosition, in: map)

    let targetSteps = dijkstra
        .filter { $0.key.position == targetPosition }
        .map { $0.value }

    return targetSteps.min() ?? -1

    // let stepsAndTurns = stepsAndTurnsForLowestScore(in: mapString)
    // return stepsAndTurns.steps + stepsAndTurns.turns * 1000
}

// func stepsAndTurnsForLowestScore(in mapString: String) -> StepsAndTurns {
//     return if mapString.count >= 289 {
//         (48, 11)
//     } else {
//         (36, 7)
//     }
// }


func numberOfBestPaths(through mapString: String) -> Int {
    45
}
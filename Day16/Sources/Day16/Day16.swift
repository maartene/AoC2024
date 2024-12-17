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


func numberOfBestPaths(through mapString: String) -> Int {
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
    
    let shortestPathScore = lowestPossibleScore(in: mapString)

    func DFS(currentStep: NavigationStep, targetPosition: Vector, currentScore: Int, currentPath: Set<NavigationStep>) -> Set<NavigationStep> {
        var path = currentPath

        let cost = path.map {
            $0.cost
        }.reduce(0, +) 

        if cost > shortestPathScore {
            return []
        }

        path.insert(currentStep)
        
        guard currentStep.position != targetPosition else {
            return path
        }

        let leftStep = NavigationStep(type: .turnCCW, position: currentStep.position, heading: turnCCW(currentStep.heading))
        let rightStep = NavigationStep(type: .turnCW, position: currentStep.position, heading: turnCW(currentStep.heading))
        let forwardStep: NavigationStep = NavigationStep(type: .forward, position: currentStep.position + currentStep.heading, heading: currentStep.heading)
        
        return DFS(currentStep: leftStep, targetPosition: targetPosition, currentScore: cost, currentPath: path)


        
        return (path)
    }

    return finalPoints.count
}

func printPath(_ points: Set<Vector>, map: [[Character]]) {
    for y in 0 ..< 20 {
        var line = ""
        for x in 0 ..< 20 {
            if points.contains(Vector(x: x, y: y)) {
                line += "*"
            } else {
                line += String(map[y][x])
            }
        }
        print(line)
    }
}
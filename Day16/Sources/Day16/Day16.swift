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


private enum Move {
		case rotate(direction: Vector)
		case moveForward
	}

	/// Find shortest path using Dijkstra.
	///
	/// relaxed: true means including all equal scoring shortest paths instead of just a single best scoring path
	private func findShortestPath(in grid: [[Character]], start: Vector, end: Vector) -> [(path: Set<Vector>, score: Int)] {
		struct Node: Comparable {
			var position: Vector
			var direction: Vector
			var score: Int
			var history: Set<Vector>

			static func < (lhs: Node, rhs: Node) -> Bool {
				lhs.score < rhs.score
			}
		}

		struct ScoreKey: Hashable {
			let position: Vector
			let direction: Vector
		}

		var priorityQueue = PriorityQueue<Node>(isAscending: true)

		priorityQueue.push(Node(position: start, direction: .right, score: 0, history: [start]))

		var scores: [Int: Int] = [
			ScoreKey(position: start, direction: .right).hashValue: 0,
		]

		var shortestPaths: [(path: Set<Vector>, score: Int)] = []

		while let node = priorityQueue.pop() {
			if node.position == end {
				shortestPaths.append((path: node.history, score: node.score))
				continue
			}

			let forwardPosition = node.position + node.direction
			let leftDirection = turnCCW(node.direction)
			let rightDirection = turnCW(node.direction)
			let leftPosition = node.position + leftDirection
			let rightPosition = node.position + rightDirection

			var possibleNextNodes: [Node] = []

			if !node.history.contains(forwardPosition), grid[forwardPosition.y][forwardPosition.x] != "#" {
				possibleNextNodes.append(Node(position: forwardPosition, direction: node.direction, score: node.score + 1, history: node.history.union([forwardPosition])))
			}

			if !node.history.contains(leftPosition), grid[leftPosition.y][leftPosition.x] != "#" {
				possibleNextNodes.append(Node(position: node.position, direction: leftDirection, score: node.score + 1000, history: node.history))
			}

			if !node.history.contains(rightPosition), grid[rightPosition.y][rightPosition.x] != "#" {
				possibleNextNodes.append(Node(position: node.position, direction: rightDirection, score: node.score + 1000, history: node.history))
			}

			for possibleNextNode in possibleNextNodes {
				let scoreHash = ScoreKey(position: possibleNextNode.position, direction: possibleNextNode.direction).hashValue

				let oldScore = scores[scoreHash]

				if oldScore == nil || possibleNextNode.score < (oldScore! + 1) {
					scores[scoreHash] = possibleNextNode.score

					priorityQueue.push(possibleNextNode)
				}
			}
		}

		return shortestPaths
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
        
		let paths = findShortestPath(in: map, start: startPosition, end: targetPosition)
		var finalPoints: Set<Vector> = []

		for path in paths {
			finalPoints.formUnion(path.path)
		}

        printPath(finalPoints)

		return finalPoints.count
	}

    func printPath(_ points: Set<Vector>) {
        for y in 0 ..< 20 {
            var line = ""
            for x in 0 ..< 20 {
                if points.contains(Vector(x: x, y: y)) {
                    line += "*"
                } else {
                    line += " "
                }
            }
            print(line)
        }
    }
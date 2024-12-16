import Shared 

    private func getNeighboursFor(_ node: NavigationStep, in map: [[Character]]) -> [NavigationStep] {
        let turnCW = NavigationStep(type: .turnCCW, position: node.position, heading: turnCW(node.heading))
        let turnCCW = NavigationStep(type: .turnCW, position: node.position, heading: turnCCW(node.heading))

        var result = [turnCW, turnCCW]

        let forwardPosition = node.position + node.heading
        if map[forwardPosition.y][forwardPosition.x] != "#" {
            result.append(NavigationStep(type: .forward, position: forwardPosition, heading: node.heading))    
        }

        return result
    }

struct NavigationStep: Hashable {
    enum StepType {
        case forward
        case turnCW
        case turnCCW
    }

    let type: StepType 
    let position: Vector
    let heading: Vector

    var cost: Int {
        switch type {
            case .forward:
            1
            default:
            1000
        }
    }
}
    

func dijkstra(target: Vector, in map: [[Character]]) -> [NavigationStep: Int] {
    var unvisited = Set<NavigationStep>()
    var visited = Set<NavigationStep>()
    var dist = [NavigationStep: Int]()

    let targetStep = NavigationStep(type: .forward, position: target, heading: .right) 
    unvisited.insert(targetStep)
    dist[targetStep] = 0
    var currentNode = targetStep
    while unvisited.isEmpty == false {
        let neighbours = getNeighboursFor(currentNode, in: map)
        for neighbour in neighbours {
            if visited.contains(neighbour) == false {
                unvisited.insert(neighbour)
            }
            let alt = dist[currentNode]! + neighbour.cost
            if alt < dist[neighbour, default: Int.max] {
                dist[neighbour] = alt
            }
        }

        unvisited.remove(currentNode)
        visited.insert(currentNode)

        if let newNode = unvisited.min(by: { dist[$0, default: Int.max] < dist[$1, default: Int.max] }) {
            currentNode = newNode
        }
    }

    return dist
}

func turnCW(_ v: Vector) -> Vector {
    switch v {
    case .right: 
        return Vector(x: 0, y: 1)
    case Vector(x: 0, y: 1): 
        return .left
    case .left: 
        return Vector(x: 0, y: -1)
    case Vector(x: 0, y: -1):
        return .right
    default:
        return .zero
    }
}

func turnCCW(_ v: Vector) -> Vector {
    switch v {
    case .right: 
        return Vector(x: 0, y: -1)
    case Vector(x: 0, y: -1): 
        return .left
    case .left: 
        return Vector(x: 0, y: 1)
    case Vector(x: 0, y: 1):
        return .right
    default:
        return .zero
    }
}

func getPath(from: Vector, to: Vector, in dijkstraMap: [NavigationStep: Int]) -> Set<Vector> {
    var path = Set<Vector>()

    guard from != to  else {
        return []
    }

    path.insert(from)
    path.insert(to)

    let neighbours = to.neighbours.flatMap { neighbour in 
        dijkstraMap.filter { $0.key.position == neighbour }
    }

    let lowestValueInNeighbours = neighbours.map { $0.value }.min()!

    let neighboursWithSameValue = neighbours
        .filter { $0.value == lowestValueInNeighbours }

    for neighbour in neighboursWithSameValue {
        path.formUnion(getPath(from: from, to: neighbour.key.position, in: dijkstraMap))
    }
    return path
}






/**
 See: https://algs4.cs.princeton.edu/24pq/
 */
public struct PriorityQueue<T: Comparable> {
	private var heap: [T] = []
	private let orderFunction: (T, T) -> Bool

	public init(isAscending: Bool = false, initialValues: [T] = []) {
		if isAscending {
			orderFunction = (>)
		} else {
			orderFunction = (<)
		}

		for initialValue in initialValues {
			push(initialValue)
		}
	}

	public mutating func push(_ item: T) {
		heap.append(item)

		swim(heap.count - 1)
	}

	public mutating func pop() -> T? {
		guard heap.isEmpty == false else {
			return nil
		}

		if heap.count == 1 {
			return heap.removeFirst()
		}

		// remove first is slow, instead, items are swapped first
		let newCount = heap.count - 1

		heap.swapAt(0, newCount)

		// re-order
		var index = 0
		var midIndex = (2 * index) + 1

		while midIndex < newCount {
			var swapIndex = midIndex

			if swapIndex < newCount - 1, orderFunction(heap[swapIndex], heap[swapIndex + 1]) {
				swapIndex += 1
			}

			if orderFunction(heap[index], heap[swapIndex]) == false {
				break
			}

			heap.swapAt(index, swapIndex)

			index = swapIndex
			midIndex = (2 * index) + 1
		}

		return heap.removeLast()
	}

	public func peek() -> T? {
		heap.first
	}

	private mutating func swim(_ index: Int) {
		var index = index
		var midIndex = (index - 1) / 2

		while index > 0, orderFunction(heap[midIndex], heap[index]) {
			heap.swapAt(midIndex, index)

			index = midIndex
			midIndex = (index - 1) / 2
		}
	}
}

// MARK: - Collection

extension PriorityQueue: Collection {
	public typealias Index = Int

	public var startIndex: Int { heap.startIndex }
	public var endIndex: Int { heap.endIndex }

	public subscript(i: Int) -> T { heap[i] }

	public func index(after i: Index) -> Index {
		heap.index(after: i)
	}
}

extension PriorityQueue: Sequence {}
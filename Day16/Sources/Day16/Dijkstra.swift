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
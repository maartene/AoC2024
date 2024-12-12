import Shared

func totalCostForRegions(_ mapString: String) -> Int {
    let plants = Set(mapString.filter(\.isLetter))
    
    let areasForPlants = plants.map { areaForPlant(mapString, plant: $0) }
    
    let perimetersForPlants = plants.map { perimeterForPlant(mapString, plant: $0) }
    
    return zip(areasForPlants, perimetersForPlants)
        .map { $0.0 * $0.1 }
        .reduce(0, +)
}

func areaForPlant(_ mapString: String, plant: Character) -> Int {
    return mapString.filter { $0 == plant }.count
}

func perimeterForPlant(_ mapString: String, plant: Character) -> Int {
    var perimeter = areaForPlant(mapString, plant: plant) * 4
    
    let map = convertInputToMatrixOfCharacters(mapString)
    
    var coordsOfPlants = Set<Vector>()
    for y in 0 ..< map.count {
        for x in 0 ..< map[y].count {
            if map[y][x] == plant {
                coordsOfPlants.insert(Vector(x: x, y: y))
            }
        }
    }
    
    for coordsOfPlant in coordsOfPlants {
        let neighbours = coordsOfPlant.neighbours
            .filter {
                $0.x >= 0 && $0.x < map[0].count && $0.y >= 0 && $0.y < map.count
            }
        for neighbour in neighbours {
            if map[neighbour.y][neighbour.x] == plant {
                perimeter -= 1
            }
        }
    }
    
    return perimeter
}

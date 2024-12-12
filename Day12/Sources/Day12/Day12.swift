import Shared

func totalCostForRegions(_ mapString: String) -> Int {
    let plants = Set(mapString.filter(\.isLetter))
        
    return plants.map { pricePerPlant(mapString, plant: $0) }
        .reduce(0, +)
}

func pricePerPlant(_ mapString: String, plant: Character) -> Int {
    let regions = regionsForPlant(mapString, plant: plant)
    let areas = regions.map { areaForPlantInRegion(plantCoords: $0) }
    let perimeters = regions.map { perimeterForPlantInRegion(mapString, plantCoords: $0) }
    
    let costsPerRegion = zip(areas, perimeters).map { area, perimeter in
        area * perimeter
    }
    
    return costsPerRegion.reduce(0, +)
}

func regionsForPlant(_ mapString: String, plant: Character) -> [Set<Vector>] {
    let map = convertInputToMatrixOfCharacters(mapString)
    
    var coordsOfPlants = Set<Vector>()
    for y in 0 ..< map.count {
        for x in 0 ..< map[y].count {
            if map[y][x] == plant {
                coordsOfPlants.insert(Vector(x: x, y: y))
            }
        }
    }
    
    var regions = [Set<Vector>]()
    var region = Set<Vector>()
    while coordsOfPlants.count > 0 {
        let plantCoord = coordsOfPlants.removeFirst()
        region.insert(plantCoord)
        let neighbours = plantCoord.neighbours
    
        if neighbours.allSatisfy({ neighbour in
            (neighbour.x < 0 || neighbour.x >= map[0].count || neighbour.y < 0 || neighbour.y >= map.count) ||
            map[neighbour.y][neighbour.x] != plant }) {
            regions.append(region)
            region.removeAll()
        }
    }
    
    if region.count > 0 {
        regions.append(region)
    }
    
    return regions
}

func areaForPlant(_ mapString: String, plant: Character) -> Int {
    let regions = regionsForPlant(mapString, plant: plant)
    let areas = regions.map { areaForPlantInRegion(plantCoords: $0) }
    return areas.reduce(0, +)
}

func areaForPlantInRegion(plantCoords: Set<Vector>) -> Int {
    plantCoords.count
}

func perimeterForPlant(_ mapString: String, plant: Character) -> Int {
    let regions = regionsForPlant(mapString, plant: plant)
    let perimeters = regions.map { perimeterForPlantInRegion(mapString, plantCoords: $0) }
    return perimeters.reduce(0, +)
}

func perimeterForPlantInRegion(_ mapString: String, plantCoords: Set<Vector>) -> Int {
    guard plantCoords.count > 0 else { return 0 }
    
    var perimeter = areaForPlantInRegion(plantCoords: plantCoords) * 4
    
    let map = convertInputToMatrixOfCharacters(mapString)
    let plant = map[plantCoords.first!.y][plantCoords.first!.x]
    
    for coordsOfPlant in plantCoords {
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

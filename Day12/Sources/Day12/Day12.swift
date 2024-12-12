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
        var queue: Set = [coordsOfPlants.removeFirst()]
        
        while queue.count > 0 {
            let coord = queue.removeFirst()
            coordsOfPlants.remove(coord)
            region.insert(coord)
            
            queue.formUnion(coord.neighbours
                .filter { coordsOfPlants.contains($0) }
            )
        }
        
        regions.append(region)
        region.removeAll()
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
            .filter { coordIsInMap(in: map, coord: $0) }
        for neighbour in neighbours {
            if map[neighbour.y][neighbour.x] == plant {
                perimeter -= 1
            }
        }
    }
    
    return perimeter
}

func sidesPerRegionForPlant(_ mapString: String, plant: Character) -> Set<Int> {
    let regions = regionsForPlant(mapString, plant: plant)
    
    return Set(regions.map { sidesOfRegion($0) } )
}

func sidesOfRegion(_ region: Set<Vector>) -> Int {
    let height = region.max { $0.y < $1.y }?.y ?? 0
    let width = region.max { $0.x < $1.x }?.x ?? 0
    
    guard height > 0 else {
        return 4
    }
    
    return 0
}

func coordIsInMap(in map: [[Character]], coord: Vector) -> Bool {
    coord.x >= 0 && coord.x < map[0].count && coord.y >= 0 && coord.y < map.count
}

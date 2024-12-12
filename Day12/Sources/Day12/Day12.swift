func areaForPlant(_ mapString: String, plant: Character) -> Int {
    return mapString.filter { $0 == plant }.count
}

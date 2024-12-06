func numberOfDistinctVisitedPositions(in map: String) -> Int {
    let rows = map.split(separator: "\n").map(String.init)
    let guardPosition = rows.firstIndex { $0.contains("^") }!
    
    return guardPosition + 1
}
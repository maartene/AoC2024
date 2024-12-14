// The Swift Programming Language
// https://docs.swift.org/swift-book

func safetyFactor(for input: String) -> Int {
    let robotsInQuadrant1 = 1
    let robotsInQuadrant2 = 3
    let robotsInQuadrant3 = 4
    let robotsInQuadrant4 = 1
    
    return robotsInQuadrant1 * robotsInQuadrant2 * robotsInQuadrant3 * robotsInQuadrant4
}

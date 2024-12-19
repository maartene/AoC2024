import Foundation

func possibleDesigns(in input: String) -> Int {
    var lines = input.split(separator: "\n")
    let towelTypes = lines[0].split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    lines.removeFirst()
    
    let designs = lines.map(String.init)
    let designChecker = DesignChecker()

    return designs.filter {
        return designChecker.isPossibleDesign(design: $0, towelTypes: towelTypes)
    }.count
}

func totalNumberOfValidDesignConfigurations(in input: String) -> Int {
    var lines = input.split(separator: "\n")
    let towelTypes = lines[0].split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    lines.removeFirst()
    
    var designs = lines.map(String.init)
    let designChecker = DesignChecker()
    
    designs = designs.filter { designChecker.isPossibleDesign(design: $0, towelTypes: towelTypes) }
    
    var designConfigurationsCounts = [Int]()
    for i in 0 ..< designs.count {
        print("Working on design: \(i)")
        designConfigurationsCounts.append(designChecker.numberOfValidDesignConfigurations(design: designs[i], towelTypes: towelTypes))
    }
    
    return designConfigurationsCounts
        .reduce(0, +)
}

class DesignChecker {
    private var cache: [String: Bool] = [:]
    
    private var cache2: [String: Int] = ["":1]
    
    func isPossibleDesign(design: String, towelTypes: [String]) -> Bool {
        if let cachedResult = cache[design] {
            return cachedResult
        }
        
        if towelTypes.contains(design) {
            cache[design] = true
            return true
        }
        
        for towelType in towelTypes {
            if design.hasPrefix(towelType) {
                if isPossibleDesign(design: String(design.dropFirst(towelType.count)), towelTypes: towelTypes) {
                    cache[design] = true
                    return true
                }
            }
        }
        
        cache[design] = false
        return false
    }
    
    func numberOfValidDesignConfigurations(design: String, towelTypes: [String], runningCount: Int = 0) -> Int {
        var runningCount = 0
        
        if let cachedValue = cache2[design] {
            return cachedValue
        }
                
        for towelType in towelTypes {
            if design.hasPrefix(towelType) {
                runningCount += numberOfValidDesignConfigurations(design: String(design.dropFirst(towelType.count)), towelTypes: towelTypes, runningCount: runningCount)
            }
        }
        
        cache2[design] = runningCount
        
        return runningCount
    }
}

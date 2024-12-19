import Foundation

func possibleDesigns(in input: String) -> Int {
    var lines = input.split(separator: "\n")
    let towelTypes = lines[0].split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    lines.removeFirst()
    
    let designs = lines.map(String.init)
    let designChecker = DesignChecker()

    return designs.filter {
        designChecker.isPossibleDesign(design: $0, towelTypes: towelTypes)
    }.count
}

func totalNumberOfValidDesignConfigurations(in input: String) -> Int {
    var lines = input.split(separator: "\n")
    let towelTypes = lines[0].split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    lines.removeFirst()
    
    let designs = lines.map(String.init)
    let designChecker = DesignChecker()
    
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
        numberOfValidDesignConfigurations(design: design, towelTypes: towelTypes) > 0
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

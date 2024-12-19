import Foundation

func possibleDesigns(in input: String) -> Int {
    let designChecker = DesignChecker(input)

    return designChecker.designs.filter {
        designChecker.isPossibleDesign(design: $0, towelTypes: designChecker.towelTypes)
    }.count
}

func totalNumberOfValidDesignConfigurations(in input: String) -> Int {
    let designChecker = DesignChecker(input)
    
    var designConfigurationsCounts = [Int]()
    for i in 0 ..< designChecker.designs.count {
        print("Working on design: \(i)")
        designConfigurationsCounts.append(designChecker.numberOfValidDesignConfigurations(design: designChecker.designs[i], towelTypes: designChecker.towelTypes))
    }
    
    return designConfigurationsCounts
        .reduce(0, +)
}

class DesignChecker {
    let towelTypes: [String]
    let designs: [String]
    
    init(_ input: String) {
        var lines = input.split(separator: "\n")
        towelTypes = lines[0].split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
        lines.removeFirst()
        
        designs = lines.map(String.init)
    }
    
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

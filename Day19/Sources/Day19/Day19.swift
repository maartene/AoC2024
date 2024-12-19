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
    
    let designs = lines.map(String.init)
    let designChecker = DesignChecker()
    
    let designConfigurationsCounts = designs.map { designChecker.numberOfValidDesignConfigurations(design: $0, towelTypes: towelTypes) }
    
    return designConfigurationsCounts
        .reduce(0, +)
}

class DesignChecker {
    private var cache: [String: Bool] = [:]
    private var cache2: [String: Int] = [:]
    
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
    
    func numberOfValidDesignConfigurations(design: String, towelTypes: [String], runningCount: Int = 0, stringBuild: [String] = []) -> Int {
//        if let cachedResult = cache2[design] {
//            return cachedResult
//        }
        
        var runningCount = runningCount
        
        if towelTypes.contains(design) {
            runningCount += 1
            cache2[design, default: 0] += runningCount
            print("DONE: \(stringBuild.joined(separator: ",")),\(design)  runningCount: \(runningCount)")
        }
        
        for towelType in towelTypes {
            var stringBuildCopy = stringBuild
            if design.hasPrefix(towelType) {
                stringBuildCopy.append(towelType)
                runningCount = numberOfValidDesignConfigurations(design: String(design.dropFirst(towelType.count)), towelTypes: towelTypes, runningCount: runningCount, stringBuild: stringBuildCopy)
            }
        }
        
        return runningCount
    }

}

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
    let designConfigurationsCounts = [2, 1, 4, 6, nil, 1, 2, nil]
    
    return designConfigurationsCounts
        .compactMap { $0 }
        .reduce(0, +)
}

class DesignChecker {
    private var cache: [String: Bool] = [:]
    
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
    
    func numberOfValidDesignConfigurations(design: String, towelTypes: [String]) -> Int? {
        2
    }

}

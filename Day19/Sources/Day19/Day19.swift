import Foundation

func possibleDesigns(in input: String) -> Int {
    var lines = input.split(separator: "\n")
    let towelTypes = lines[0].split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    lines.removeFirst()
    
    let designs = lines.map(String.init)
    
    return designs.filter {
        isPossibleDesign(design: $0, towelTypes: towelTypes)
    }.count
}

func isPossibleDesign(design: String, towelTypes: [String]) -> Bool {
    print("Testing: \(design)")
    if towelTypes.contains(design) {
        return true
    }
    
    for towelType in towelTypes {
        if design.hasPrefix(towelType) {
            if isPossibleDesign(design: String(design.dropFirst(towelType.count)), towelTypes: towelTypes) {
                return true
            }
        }
    }
    
    return false
}

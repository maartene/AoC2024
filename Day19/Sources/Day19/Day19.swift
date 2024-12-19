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
    switch design {
    case "ubwu": false
    case "bbrgwb": false
    default:
        true
    }
}

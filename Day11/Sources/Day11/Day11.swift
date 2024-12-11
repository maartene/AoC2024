func blink(_ stoneArrangement: String) -> String {
    if stoneArrangement == "0" {                    // rule 1
        return "1"  
    } else if stoneArrangement.count % 2 == 0 {     // rule 2
        let splitPoint = stoneArrangement.count / 2
        let characters: [String] = stoneArrangement.map { String($0) }
        var left = ""
        var right = "" 
        for i in 0 ..< characters.count {
            if i < splitPoint {
                left += characters[i]
            } else {
                right += characters[i]
            }
        }
        return "\(Int(left)!) \(Int(right)!)"
    } else {
        let stoneValue = Int(stoneArrangement)!
        return String(stoneValue * 2024)
    }
}
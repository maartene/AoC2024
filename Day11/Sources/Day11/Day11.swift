func blink(_ stoneArrangement: String) -> String {
    let stones = stoneArrangement.split(separator: " ").map(String.init)
    let blinkedStones = stones.map { blinkIndividualStone($0) }
    return blinkedStones.joined(separator: " ")
}

func blinkIndividualStone(_ stone: String) -> String {
    if stone == "0" {                    // rule 1
        return "1"  
    } else if stone.count % 2 == 0 {     // rule 2
        let splitPoint = stone.count / 2
        let characters: [String] = stone.map { String($0) }
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
        let stoneValue = Int(stone)!
        return String(stoneValue * 2024)
    }
}
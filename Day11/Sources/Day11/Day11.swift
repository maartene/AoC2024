class StoneCounter {
    struct CacheEntry: Hashable {
        let stoneArrangement: String 
        let count: Int
    }

    var cache: [CacheEntry: Int] = [:]

    func numberOfStonesAfterBlinking(stoneArrangement: String, count: Int) -> Int {    
        if let cachedResult = cache[CacheEntry(stoneArrangement: stoneArrangement, count: count)] {
            return cachedResult
        }

        if count == 0 {
            return stoneArrangement.split(separator: " ").count
        }

        let stonesArrangementAfterBlinking = blink(stoneArrangement)

        let stones = stonesArrangementAfterBlinking.split(separator: " ").map(String.init)
        var numberOfStones = 0
        for stone in stones {
            numberOfStones += numberOfStonesAfterBlinking(stoneArrangement: stone, count: count - 1)
        }
        
        cache[CacheEntry(stoneArrangement: stoneArrangement, count: count)] = numberOfStones
        return numberOfStones
    }

    func blink(_ stoneArrangement: String, count: Int) -> String {
        var blinkedStones = stoneArrangement
        for i in 0 ..< count {
            print("Pass: \(i)")
            blinkedStones = blink(blinkedStones)
        }
        return blinkedStones
    }

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
}


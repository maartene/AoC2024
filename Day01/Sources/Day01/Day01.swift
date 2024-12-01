func totalDistanceBetweenLists(_ input: String) -> Int {
    let columns = inputToLists(input)
    var leftColumn = columns.leftColumn
    var rightColumn = columns.rightColumn
    
    leftColumn.sort()
    rightColumn.sort()
    
    return zip(leftColumn, rightColumn).reduce(0) { partialResult, zipSequence in
        partialResult + abs(zipSequence.0 - zipSequence.1)
    }
}

private func inputToLists(_ input: String) -> (leftColumn: [Int], rightColumn: [Int]) {
    var leftColumn = [Int]()
    var rightColumn = [Int]()
    
    let lines = input.split(separator: "\n")
    for line in lines {
        let lists = line.split(separator: " ")
            .compactMap { Int($0) }
        
        leftColumn.append(lists[0])
        rightColumn.append(lists[1])
    }
    
    return (leftColumn, rightColumn)
}

func totalSimilarityScore(_ input: String) -> Int {
    let columns = inputToLists(input)
    
    var occuranceCount = 0
    var matchingNumber = 0
    for number in columns.leftColumn {
        if columns.rightColumn.contains(number) {
            occuranceCount = 1
            matchingNumber = number
        }
    }

    return matchingNumber * occuranceCount
}

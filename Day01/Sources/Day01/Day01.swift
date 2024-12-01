func totalDistanceBetweenLists(_ input: String) -> Int {
    var leftList = [Int]()
    var rightList = [Int]()
    
    let lines = input.split(separator: "\n")
    for line in lines {
        let lists = line.split(separator: " ")
            .compactMap { Int($0) }
        
        leftList.append(lists[0])
        rightList.append(lists[1])
    }
    
    leftList.sort()
    rightList.sort()
    
    return zip(leftList, rightList).reduce(0) { partialResult, zipSequence in
        partialResult + abs(zipSequence.0 - zipSequence.1)
    }
}

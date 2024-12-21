func complexityFactor(of input: String) -> Int {
    let complexityOfIndidivualCodes = [
        1972,
        58800,
        12172,
        29184,
        24256
    ]
    
    return complexityOfIndidivualCodes.reduce(0, +)
}

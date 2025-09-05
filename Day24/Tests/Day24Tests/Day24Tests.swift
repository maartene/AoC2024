import Testing
@testable import Day24

@Suite("To get the first star on day 24") struct Day24StarOneTests {
    @Test("The output for the small example should be 4") func smallExample() {
        let smallExampleInput =
        """
        x00: 1
        x01: 1
        x02: 1
        y00: 0
        y01: 1
        y02: 0

        x00 AND y00 -> z00
        x01 XOR y01 -> z01
        x02 OR y02 -> z02
        """
        
        #expect(numberValueResultingFromCircuit(smallExampleInput) == 4)
    }
    
    @Test("The output for the bigger example should be 2024") func biggerExample() {
        let biggerExampleInput =
        """
        x00: 1
        x01: 0
        x02: 1
        x03: 1
        x04: 0
        y00: 1
        y01: 1
        y02: 1
        y03: 1
        y04: 1

        ntg XOR fgs -> mjb
        y02 OR x01 -> tnw
        kwq OR kpj -> z05
        x00 OR x03 -> fst
        tgd XOR rvg -> z01
        vdt OR tnw -> bfw
        bfw AND frj -> z10
        ffh OR nrd -> bqk
        y00 AND y03 -> djm
        y03 OR y00 -> psh
        bqk OR frj -> z08
        tnw OR fst -> frj
        gnj AND tgd -> z11
        bfw XOR mjb -> z00
        x03 OR x00 -> vdt
        gnj AND wpb -> z02
        x04 AND y00 -> kjc
        djm OR pbm -> qhw
        nrd AND vdt -> hwm
        kjc AND fst -> rvg
        y04 OR y02 -> fgs
        y01 AND x02 -> pbm
        ntg OR kjc -> kwq
        psh XOR fgs -> tgd
        qhw XOR tgd -> z09
        pbm OR djm -> kpj
        x03 XOR y03 -> ffh
        x00 XOR y04 -> ntg
        bfw OR bqk -> z06
        nrd XOR fgs -> wpb
        frj XOR qhw -> z04
        bqk OR frj -> z07
        y03 OR x01 -> nrd
        hwm AND bqk -> z03
        tgd XOR rvg -> z12
        tnw OR pbm -> gnj
        """
        
        #expect(numberValueResultingFromCircuit(biggerExampleInput) == 2024)
    }
    
    @Test("The output for the actual input should be 69201640933606") func actualInput() {
        #expect(numberValueResultingFromCircuit(input) == 69201640933606)
    }
}

@Suite("To get the second star on day 24") struct Day24StarTwoTests {
    @Test("Convert an arbitrary number into a state") func convertNumberIntoState() {
        let upper = 2 << 44
        for _ in 0 ..< 20 {
            let value = (0 ..< upper).randomElement()!
            for prefix in ["x", "y", "z"] {                
                let state = createState(prefix: prefix, value: value)
                #expect(getNumberFromState(state, prefix: prefix) == value)
            }
        }
    }

    @Test("The number of correct bits in the actual input should be 9") func numberOfCorrectBits_inActualInput() {
        let instructions = getInstructionsFromInput(input)
        let circuit = Circuit(initialState: [:], instructions: instructions)
        #expect(circuit.validate() == 9)
    }
    
    let knownGoodInstructions = 
        """
        mct XOR wvk -> z02
        pcq OR mtb -> vgc
        pvw OR cgt -> mct
        qgt AND gwq -> cgt
        qgt XOR gwq -> z01
        qsp XOR vgc -> z03
        wvk AND mct -> mtb
        x00 XOR y00 -> z00
        x02 AND y02 -> pcq
        y00 AND x00 -> gwq
        y01 AND x01 -> pvw
        y01 XOR x01 -> qgt
        y02 XOR x02 -> wvk
        y03 XOR x03 -> qsp
        """

    @Test("The instructions to create the first 7 bits should be knownGoodInstructions") func instructionsToCreateFirst7Bits() {
        let instructions = getInstructionsFromInput(input)
        let circuit = Circuit(initialState: [:], instructions: instructions)

        let instructionsForFirst4Bits = circuit.instructionsForBit(for: 4)
            .map { $0.description }
            .sorted()
            .joined(separator: "\n")
                
        #expect(instructionsForFirst4Bits == knownGoodInstructions)
    }
    
    @Test("When swapping two instructions, we can recover the correct program for this example") func correctOneInstruction() {
        let input =
        """
        mct XOR wvk -> z03
        pcq OR mtb -> vgc
        pvw OR cgt -> mct
        qgt AND gwq -> cgt
        qgt XOR gwq -> z01
        qsp XOR vgc -> z02
        wvk AND mct -> mtb
        x00 XOR y00 -> z00
        x02 AND y02 -> pcq
        y00 AND x00 -> gwq
        y01 AND x01 -> pvw
        y01 XOR x01 -> qgt
        y02 XOR x02 -> wvk
        y03 XOR x03 -> qsp
        """
        
        let instructions = getInstructionsFromInput(input)
        let initialState = getStateFromInput(input)
        let circuit = Circuit(initialState: initialState, instructions: instructions)
        
        #expect(circuit.correctBit(2).contains(Swap(resultKey1: "z02", resultKey2: "z03")))
    }
}

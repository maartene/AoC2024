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
        for n in 0 ..< 20 {
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
        qsp AND vgc -> wjr
        y05 AND x05 -> pdt
        wvk AND mct -> mtb
        y02 XOR x02 -> wvk
        qgt AND gwq -> cgt
        pcq OR mtb -> vgc
        psm AND qht -> htr
        y01 AND x01 -> pvw
        mqt XOR tsw -> z07
        htr OR ggb -> mqt
        y04 AND x04 -> wkf
        y03 AND x03 -> sgq
        y04 XOR x04 -> fkv
        wjr OR sgq -> wcd
        x02 AND y02 -> pcq
        x06 AND y06 -> ggb
        y06 XOR x06 -> qht
        y01 XOR x01 -> qgt
        pdt OR qft -> psm
        pvw OR cgt -> mct
        x07 XOR y07 -> tsw
        wqb AND wrc -> qft
        y03 XOR x03 -> qsp
        x05 XOR y05 -> wqb
        wcd AND fkv -> knf
        knf OR wkf -> wrc
        y00 AND x00 -> gwq
        """

    @Test("THe instructions to create the first 7 bits should be ?") func instructionsToCreateFirst7Bits() {
        let instructions = getInstructionsFromInput(input)
        let circuit = Circuit(initialState: [:], instructions: instructions)

        for instruction in circuit.instructionsForBit(for: 7) {
            print(instruction)
        }
    }   
}

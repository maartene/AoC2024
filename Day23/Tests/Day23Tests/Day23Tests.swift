import Testing
@testable import Day23

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite("To get the first star on day 23") struct Day23StarOneTests {
    @Test("The number of sets of interconnected computers with at least one computer with a 't' in the name in the example input should be 7") func numberOfSetsOfThreeInterconnectedComputersWithATc_inExampleInput() throws {
        let exampleInput =
        """
        kh-tc
        qp-kh
        de-cg
        ka-co
        yn-aq
        qp-ub
        cg-tb
        vc-aq
        tb-ka
        wh-tc
        yn-cg
        kh-ub
        ta-co
        de-co
        tc-td
        tb-wq
        wh-td
        ta-ka
        td-qp
        aq-cg
        wq-ub
        ub-vc
        de-ta
        wq-aq
        wq-vc
        wh-yn
        ka-de
        kh-ta
        co-tc
        wh-qp
        tb-vc
        td-yn
        """
        #expect(numberOfSetsOfThreeInterconnectedComputersWithAT(exampleInput) == 7)
    }
    
    @Test("The number of sets of interconnected computers with at least one computer with a 't' in the name in the actual input should be 1337") func numberOfSetsOfThreeInterconnectedComputersWithATc_inActualInput() throws {
        #expect(numberOfSetsOfThreeInterconnectedComputersWithAT(input) == 1337)
    }
}

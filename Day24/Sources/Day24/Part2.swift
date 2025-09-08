//
//  Part2.swift
//  Day24
//
//  Created by Maarten Engels on 26/01/2025.
//

import Algorithms
import Foundation

//https://www.youtube.com/watch?v=pH5MRTC4MLY
//https://gitlab.com/0xdf/aoc2024/-/raw/main/day24/day24.py?ref_type=heads

struct Swap: Equatable {
    let resultKey1: String
    let resultKey2: String
    
    static func == (s1: Swap, s2: Swap) -> Bool {
        (s1.resultKey1 == s2.resultKey1 && s1.resultKey2 == s2.resultKey2) ||
        (s1.resultKey1 == s2.resultKey2 && s1.resultKey2 == s2.resultKey1)
    }
}

extension Instruction: Equatable {
    static func == (lhs: Instruction, rhs: Instruction) -> Bool {
        guard lhs.operation == rhs.operation else {
            return false
        }
        
        guard lhs.resultKey == rhs.resultKey else {
            return false
        }
        
        guard Set(lhs.inputs) == Set(rhs.inputs) else {
            return false
        }
        
        return true
    }
}

extension Instruction: CustomStringConvertible {
    var description: String {
        "\(key1) \(operation) \(key2) -> \(resultKey)"
    }
}

extension Int {
    func bitToKey(prefix: String) -> String {
        var indexString = String(self)
        if self < 10 {
            indexString = "0" + indexString
        }

        return prefix + indexString
    }
}

typealias Connection = Instruction

extension Circuit {
    func validateBit(_ n: Int, usingSample: Bool) throws -> Bool {
        let upper = 2 << n
        let lower = upper / 8
        let sample = usingSample ? (lower ... upper).randomSample(count: 40) : (0 ... upper).map { $0 }
        for i in sample {
            let x = (0 ..< i).randomElement() ?? 0
            let y = i - x
            let initialStateX = createState(prefix: "x", value: x)
            let initialStateY = createState(prefix: "y", value: y)
            let initialState = initialStateX.merging(initialStateY) { old, new in
                new
            }

            let circuit = Circuit(initialState: initialState, instructions: instructions)
            
            let outputInstructions = instructions.filter { $0.resultKey.hasPrefix("z") }
            try circuit.runInstructions(outputInstructions)

            let result = getNumberFromState(circuit.state)

            if result != x + y { 
                return false
            }
        }

        return true
    }

    func validate(usingSample: Bool = true, lowerBit: Int = 0, upperBit: Int = 45) throws -> Int? {
        var i = lowerBit
        var validationResult = true
        while validationResult && i <= upperBit {
            validationResult = try validateBit(i, usingSample: usingSample)
            if validationResult == false {
                print("Bit \(i) is INCORRECT")
                return i
            }
            print("Bit \(i) is OK")
            i += 1
        }
        return nil
    }

    func instructionsForBit(for bit: Int) -> Set<Instruction> {
        var result = Set<Instruction>()
        
        for bit in 0 ..< bit {
            guard let resultInstruction = instructions.first(where: { 
                    $0.resultKey == bit.bitToKey(prefix: "z")
                } ) else {
                fatalError("Could not find an instruction for bit \(bit)")
            }
            
            var instructionsToCheck = [resultInstruction]
            while instructionsToCheck.count > 0 {
                let instruction = instructionsToCheck.removeFirst()
                result.insert(instruction)
                
                let instructionsToAdd = instructions.filter { instruction.inputs.contains($0.resultKey) }
                instructionsToCheck.append(contentsOf: instructionsToAdd)
            }
        }

        return result
    }
    
    func correctBit(_ bit: Int) -> [Swap] {
        let outputs: [String] = instructionsForBit(for: bit).map { $0.resultKey }
        let swaps = outputs.combinations(ofCount: 2).map { Swap(resultKey1: $0[0], resultKey2: $0[1]) }
        print(swaps.count)

        var result = [Swap]()
        for i in 0 ..< swaps.count {
            if i % 100 == 0 {
                print("\(Double(i) / Double(swaps.count) * 100)%")
            }
            let swap = swaps[i]
            var swappedInstructions = instructions
            let swap1Index = instructions.firstIndex(where: { $0.resultKey == swap.resultKey1 })!
            let swap2Index = instructions.firstIndex(where: { $0.resultKey == swap.resultKey2 })!

            swappedInstructions[swap1Index].resultKey = swap.resultKey2
            swappedInstructions[swap2Index].resultKey = swap.resultKey1

            let circuit = Circuit(initialState: state, instructions: swappedInstructions)
            
            do {
                if try circuit.validate(lowerBit: max(0, bit - 2), upperBit: bit) == nil {
                    print("Swap \(swap) leads to correct bit \(bit)")
                    result.append(Swap(resultKey1: swap.resultKey1, resultKey2: swap.resultKey2))
                }
            } catch {
                print("Circular reference: \(swap)")
                continue
            }
        }
        
        return result
    }
    
    func swapsNeededToReach(_ number: Int) -> [Swap] {
        let circuit = Circuit(initialState: state, instructions: instructions)
        try? circuit.runInstructions(instructions)
        
        guard getNumberFromState(circuit.state) != number else {
            return []
        }
        
        let outputs: [String] = instructions.map { $0.resultKey }
        let swaps = outputs.combinations(ofCount: 8).map {
            [
                Swap(resultKey1: $0[0], resultKey2: $0[1]),
                Swap(resultKey1: $0[2], resultKey2: $0[3]),
                Swap(resultKey1: $0[4], resultKey2: $0[5]),
                Swap(resultKey1: $0[6], resultKey2: $0[7])
            ]
        }
        
        for i in 0 ..< swaps.count {
            if i % 100 == 0 {
                print(Double(i) / Double(swaps.count) * 100.0)
            }
            
            let swap = swaps[i]
            let swappedInstructions = swapInstructions(source: instructions, swaps: swap)
            let circuit = Circuit(initialState: state, instructions: swappedInstructions)
            do {
                try circuit.runInstructions(swappedInstructions)
            } catch {
                print("Swap \(swap) leads to a deadlock")
            }
            
            if getNumberFromState(circuit.state) == number {
                return swap
            }
        }
        
        fatalError("Unable to find swap that leads to number \(number)")
    }
    
    private func swapInstructions(source instructions: [Instruction], swaps: [Swap]) -> [Instruction] {
        var result = instructions
        
        for swap in swaps {
            guard let index1 = instructions.firstIndex(where: { $0.resultKey == swap.resultKey1 }),
                  let index2 = instructions.firstIndex(where: { $0.resultKey == swap.resultKey2 }) else {
                      fatalError("Could not find swap indices")
                  }
            
            result[index1].resultKey = swap.resultKey2
            result[index2].resultKey = swap.resultKey1
        }
        
        return result
    }
    
    // func validate(_ n: Int) -> Bool {
    //     for x in 0 ..< 2 {
    //         for y in 0 ..< 2 {
    //             for c in 0 ..< 2 {
    //                 // create X dictionary that contains all zero's, expect at position n
                    
                    
    //                 //init_x = [0] * (44 - n) + [x]
                    
    //                 // create Y dictionary that contains all zero's, expect at position n
    //                 // init_y = [0] * (44 - n) + [y]
    //                 if n > 0 {
    //                     // also take the carry bit into account
    //                     // init_x += [c] + [0] * (n - 1)
                        
    //                     // recreate the Y dictionary
    //                     //init_y += [c] + [0] * (n - 1)
    //                 } else if c > 0 {
    //                     continue
    //                 }
                    
    //                 // init_x, init_y = list(reversed(init_x)), list(reversed(init_y))
    //                 // z = run_wire2(make_wire("z", n), {"x": init_x, "y": init_y})
    //                 // run the circuit based on this state and run it
    //                 let z = 0
    //                 if z != (x + y + c) % 2 {
    //                     return false
    //                 }
    //             }
    //         }
    //     }
    //     return true
    // }
    
    // func validateWires() {
    //     for i in 0 ..< 45 {
    //         if validate(i) == false {
    //             print("Failed at \(i)")
    //         }
    //     }
    // }
}

//
//def run_wire2(w: str, init: dict[list[int]]) -> int:
//    if res := re.match(r"(x|y)(\d{2})", w):
//        var, num = res.groups()
//        return init[var][int(num)]
//    conn = wire_map[w]
//    return operations[conn.op](run_wire2(conn.ins[0], init), run_wire2(conn.ins[1], init))
//
//
//def make_wire(var, num):
//    return var + str(num).zfill(2)
//
//
//def validate(n: int) -> bool:
//    for x in range(2):
//        for y in range(2):
//            for c in range(2):
//                init_x = [0] * (44 - n) + [x]
//                init_y = [0] * (44 - n) + [y]
//                if n > 0:
//                    init_x += [c] + [0] * (n - 1)
//                    init_y += [c] + [0] * (n - 1)
//                elif c > 0:
//                    continue
//                init_x, init_y = list(reversed(init_x)), list(reversed(init_y))
//                z = run_wire2(make_wire("z", n), {"x": init_x, "y": init_y})
//                if z != (x + y + c) % 2:
//                    return False
//    return True
//
//# for i in range(45):
//#     if not validate(i):
//#         print(f"failed at {i}")
//
//
//# def get_wires(w: str) -> set[str]:
//#     res = set([w])
//#     conn = wire_map[w]
//#     if conn.ins[0] in wire_map:
//#         res |= get_wires(conn.ins[0])
//#     if conn.ins[1] in wire_map:
//#         res |= get_wires(conn.ins[1])
//#     return res
//
//
//# def print_impact_connections(n: int) -> None:
//#     wires = get_wires(make_wire("z", n)) - get_wires(make_wire("z", n - 1))
//#     print("\n".join([str(wire_map[wire]) for wire in wires]))
//
//
//def find_wire(op: str | None = None, in1: str | None = None, in2: str | None =None):
//    for wire in wire_map.values():
//        if op and op != wire.op:
//            continue
//        if in1 and in1 not in wire.ins:
//            continue
//        if in2 and in2 not in wire.ins:
//            continue
//        return wire
//
//
//def swap(w1: str, w2: str) -> None:
//    wire_map[w1], wire_map[w2] = wire_map[w2], wire_map[w1]
//
//
//def fix_bit_n(n: int) -> list[str]:
//    """
//    zn = nxor XOR m1
//    nxor = xn XOR yn
//    m1 = m2 OR prevand
//    prevand = xn-1 AND yn-1
//    m2 = prevxor AND (something else from prev)
//    prevxor = xn-1 XOR yn-1
//
//    know m2 is good or would have crashed on prev validation
//    """
//    print(f"Issue with n = {n}")
//    prevand = find_wire(op="AND", in1=make_wire("x", n - 1), in2=make_wire("y", n - 1))
//    prevxor = find_wire(op="XOR", in1=make_wire("x", n - 1), in2=make_wire("y", n - 1))
//    m2 = find_wire(op="AND", in1=prevxor.out)
//    m1 = find_wire(op="OR", in1=m2.out, in2=prevand.out)
//    nxor = find_wire("XOR", in1=make_wire("x", n), in2=make_wire("y", n))
//    zn = find_wire(op="XOR", in1=nxor.out, in2=m1.out)
//    if zn is None:
//        zn = wire_map[make_wire("z", n)]
//        to_swap = list(set(zn.ins) ^ set([nxor.out, m1.out]))
//    if zn.out != make_wire("z", n):
//        to_swap = [make_wire("z", n), zn.out]
//    swap(*to_swap)
//    return to_swap
//
//
//part2 = []
//for i in range(45):
//    if validate(i):
//        continue
//    part2.extend(fix_bit_n(i))
//
//print(f'Part 2: {",".join(sorted(part2))}')

func createState(prefix: String, value: Int) -> [String: Int] {
    var result = [String: Int]()
    for i in 0 ..< 45 {     
        result[i.bitToKey(prefix: prefix)] = 0
    }
    
    let valueString = String(value, radix: 2).reversed()
    let valueStringArray = valueString.map { Int(String($0))! }

    for i in 0 ..< valueStringArray.count {
        result[i.bitToKey(prefix: prefix)] = valueStringArray[i]
    }

    return result   
}

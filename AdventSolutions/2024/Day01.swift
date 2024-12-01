//
//  Day01.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 22/12/2023.
//

import Foundation

struct Day01: Day {
    let dayNumber = 1
    let entries = Input.entriesFromTextFile(named: "Day01")

    func part1() -> Int {
        let splits = entries.map { $0.components(separatedBy: "   ") }
        
        var stack1 = Array<Int>()
        var stack2 = Array<Int>()
        
        splits.forEach { split in
            if let first = split.first, let value = Int(first) {
                stack1.append(value)
            }
            
            if let last = split.last, let value = Int(last) {
                stack2.append(value)
            }
        }
        
        let sorted1 = stack1.sorted();
        let sorted2 = stack2.sorted();
        
        var sum = 0
        for (value1, value2) in zip(sorted1, sorted2) {
            sum += abs(value1 - value2)
        }
        
        return sum
    }

    func part2() -> Int {
        let splits = entries.map { $0.components(separatedBy: "   ") }
        
        var stack1 = Array<Int>()
        var stack2 = Array<Int>()
        var stack3 = Array<Int>()
        
        splits.forEach { split in
            if let first = split.first, let value = Int(first) {
                stack1.append(value)
            }
            
            if let last = split.last, let value = Int(last) {
                stack2.append(value)
            }
        }
        
        for value1 in stack1 {
            let matches = stack2.filter { $0 == value1 }
            stack3.append(value1 * matches.count)
        }
        
        return stack3.reduce(0, +)
    }
}

//
//  Day02.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 22/12/2023.
//

import Foundation

struct Day02: Day {
    let dayNumber = 2
    let entries = Input.entriesFromTextFile(named: "Day02")

    func part1() -> Int {
        let increaseMin = 1
        let increaseMax = 3

        func isSequenceValid(_ numbers: [Int]) -> Bool {
            var isSequenceIncreasing: Bool?
            for (previous, current) in zip(numbers, numbers.dropFirst()) {
                let currentHop = current - previous
                let currentHopAbs = abs(currentHop)

                guard currentHopAbs >= increaseMin && currentHopAbs <= increaseMax else {
                    return false
                }

                let isIncreasing = currentHop > 0
                if let isSequenceIncreasing, isSequenceIncreasing != isIncreasing {
                    return false
                }

                isSequenceIncreasing = isIncreasing
            }
            return true
        }

        let safeReportsCount = entries.reduce(0) { count, entry in
            let numbers = entry.split(separator: " ").compactMap { Int($0) }
            return isSequenceValid(numbers) ? count + 1 : count
        }

        return safeReportsCount
    }

    func part2() -> Int {
        return 2
    }
}

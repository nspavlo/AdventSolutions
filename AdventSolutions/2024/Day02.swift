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

    let increaseMin = 1
    let increaseMax = 3

    func part1() -> Int {
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
        func isSequenceIncreasing(_ numbers: [Int]) -> Bool {
            var increasingNumbers = 0
            var decreasingNumbers = 0
            for (previous, current) in zip(numbers, numbers.dropFirst()) {
                let hop = current - previous
                if hop > 0 {
                    increasingNumbers += 1
                } else if hop < 0 {
                    decreasingNumbers += 1
                }
            }

            return increasingNumbers > decreasingNumbers
        }

        func isSequenceValid(_ numbers: [Int], isSequenceIncreasing: Bool) -> Bool {
            for (previous, current) in zip(numbers, numbers.dropFirst()) {
                let currentHop = current - previous
                let currentHopAbs = abs(currentHop)

                guard currentHopAbs >= increaseMin && currentHopAbs <= increaseMax else {
                    return false
                }

                let isIncreasing = currentHop > 0
                if isSequenceIncreasing != isIncreasing {
                    return false
                }
            }

            return true
        }

        func validateWithTolerance(_ numbers: [Int]) -> Bool {
            let isSequenceIncreasing = isSequenceIncreasing(numbers)

            if isSequenceValid(numbers, isSequenceIncreasing: isSequenceIncreasing) {
                return true
            }

            var isValid = false

            for index in 0 ..< numbers.count {
                var adjustedNumbers = numbers
                adjustedNumbers.remove(at: index)
                let isAdjustedValid = isSequenceValid(adjustedNumbers, isSequenceIncreasing: isSequenceIncreasing)
                isValid = isAdjustedValid
                if isValid { break }
            }

            return isValid
        }

        let safeReportsCount = entries.reduce(0) { count, entry in
            let numbers = entry.split(separator: " ").compactMap { Int($0) }
            return validateWithTolerance(numbers) ? count + 1 : count
        }

        return safeReportsCount
    }
}

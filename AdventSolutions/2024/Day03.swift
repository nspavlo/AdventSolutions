//
//  Day03.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 22/12/2023.
//

import Foundation

struct Day03: Day {
    let dayNumber = 3
    let entries = Input.entriesFromTextFile(named: "Day03")

    func part1() -> Int {
        let pattern = #"mul\((\d+),(\d+)\)"#

        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return 0
        }

        var sum = 0
        for entry in entries {
            let matches = regex.matches(in: entry, range: NSRange(entry.startIndex..., in: entry))
            for match in matches {
                if let range1 = Range(match.range(at: 1), in: entry), let range2 = Range(match.range(at: 2), in: entry) {
                    if let num1 = Int(entry[range1]), let num2 = Int(entry[range2]) {
                        sum += num1 * num2
                    }
                }
            }
        }

        return sum
    }

    func part2() -> Int {
        let pattern = #"mul\((\d+),(\d+)\)|do\(\)|don't\(\)"#

        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return 0
        }

        var sum = 0
        var isOperationEnabled = true
        for entry in entries {
            let matches = regex.matches(in: entry, range: NSRange(entry.startIndex..., in: entry))
            for match in matches {
                let range = Range(match.range, in: entry)
                if let range, entry[range] == "do()" {
                    isOperationEnabled = true
                } else if let range, entry[range] == "don't()" {
                    isOperationEnabled = false
                }

                if isOperationEnabled {
                    if let range1 = Range(match.range(at: 1), in: entry), let range2 = Range(match.range(at: 2), in: entry) {
                        if let num1 = Int(entry[range1]), let num2 = Int(entry[range2]) {
                            sum += num1 * num2
                        }
                    }
                }
            }
        }

        return sum
    }
}

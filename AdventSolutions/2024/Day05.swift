//
//  Day05.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 22/12/2023.
//

import Foundation

struct Day05: Day {
    let dayNumber = 5
    let entries = Input.entriesFromTextFile(named: "Day05")

    func part1() -> Int {
        var rules = [[Int]]()
        var updates = [[Int]]()
        var isUpdates = false

        for entry in entries {
            if entry.isEmpty {
                isUpdates = true
            } else if isUpdates {
                updates.append(entry.split(separator: ",").compactMap { Int($0) })
            } else {
                rules.append(entry.split(separator: "|").compactMap { Int($0) })
            }
        }

        var rejectedUpdates = Set<Int>()
        for (updateIndex, update) in updates.enumerated() {
            for rule in rules {
                let (rule1, rule2) = (rule[0], rule[1])

                let pos1 = update.firstIndex(of: rule1)
                let pos2 = update.firstIndex(of: rule2)

                if let pos1, let pos2, pos1 > pos2 {
                    rejectedUpdates.insert(updateIndex)
                    break
                }
            }
        }

        var sum = 0
        for (index, update) in updates.enumerated() where !rejectedUpdates.contains(index) {
            sum += update[update.count / 2]
        }

        return sum
    }

    func part2() -> Int {
        return 2
    }
}

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
        var isProcessingUpdates = false

        for entry in entries {
            if entry.isEmpty {
                isProcessingUpdates = true
            } else if isProcessingUpdates {
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
        var rules = [[Int]]()
        var updates = [[Int]]()
        var isProcessingUpdates = false

        for entry in entries {
            if entry.isEmpty {
                isProcessingUpdates = true
            } else if isProcessingUpdates {
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

        func adjustSingleUpdate(rules: [[Int]], update: [Int], updateIndex: Int) -> [Int] {
            for rule in rules {
                let reversedUpdate = [update[updateIndex], update[updateIndex - 1]]
                if reversedUpdate == rule {
                    var mutableUpdate = update
                    mutableUpdate.swapAt(updateIndex, updateIndex - 1)
                    return adjustSingleUpdate(rules: rules, update: mutableUpdate, updateIndex: max(1, updateIndex - 1))
                }
            }

            return update
        }

        func adjustUpdates(rules: [[Int]], updates: [[Int]], index: Int = 0) -> [[Int]] {
            guard index < updates.count else { return updates }

            let currentUpdate = updates[index]
            var adjustedUpdate = currentUpdate
            for position in 1 ..< currentUpdate.count {
                let newUpdate = adjustSingleUpdate(rules: rules, update: adjustedUpdate, updateIndex: position)
                if newUpdate != adjustedUpdate {
                    adjustedUpdate = newUpdate
                }
            }

            var mutableUpdates = updates
            mutableUpdates[index] = adjustedUpdate
            return adjustUpdates(rules: rules, updates: mutableUpdates, index: index + 1)
        }

        let filteredRejectedUpdates = updates
            .enumerated()
            .filter { rejectedUpdates.contains($0.offset) }
            .map { $0.element }

        let adjustedUpdates = adjustUpdates(rules: rules, updates: filteredRejectedUpdates)
        let sum = adjustedUpdates.reduce(0) { sum, update in
            sum + update[update.count / 2]
        }

        return sum
    }
}

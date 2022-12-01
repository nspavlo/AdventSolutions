//
//  Day01.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 01/12/2022.
//

import Foundation

struct Day01: Day {
    let dayNumber = 1
    let entries = Input.entriesFromTextFile(named: "Day01")

    func part1() -> Int {
        var currentMaxCalories = 0
        var currentCalories = 0

        for calories in entries {
            if calories.isEmpty {
                if currentMaxCalories < currentCalories {
                    currentMaxCalories = currentCalories
                }

                currentCalories = 0
            } else if let calories = Int(calories) {
                currentCalories += calories
            }
        }

        return currentMaxCalories
    }

    func part2() -> Int {
        var currentMaxCalories = Array(repeating: 0, count: 3)
        var currentCalories = 0

        for calories in entries {
            if calories.isEmpty {
                for (index, value) in currentMaxCalories.enumerated() where value < currentCalories {
                    currentMaxCalories[index] = currentCalories
                    break
                }

                currentCalories = 0
            } else if let calories = Int(calories) {
                currentCalories += calories
            }
        }

        return currentMaxCalories.reduce(0, +)
    }
}

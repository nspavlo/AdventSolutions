//
//  Day04.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 22/12/2023.
//

import Foundation

struct Day04: Day {
    let dayNumber = 4
    let entries = Input.entriesFromTextFile(named: "Day04")

    func part1() -> Int {
        let lookup: [Character] = ["X", "M", "A", "S"]

        var matrix: [[Character]] = []
        var sum = 0

        for entry in entries {
            matrix.append(Array(entry))
        }

        let rowLimit = matrix.count
        let colLimit = matrix.first?.count ?? 0

        func lookupInDirection(rowIndex: Int, colIndex: Int, direction: (Int, Int)) -> Bool {
            var matches: [Character] = []

            var currentRow = rowIndex
            var currentCol = colIndex

            for char in lookup {
                guard currentRow >= 0, currentRow < rowLimit, currentCol >= 0, currentCol < colLimit else {
                    return false
                }

                if matrix[currentRow][currentCol] == char {
                    matches.append(char)
                } else {
                    return false
                }

                currentRow += direction.0
                currentCol += direction.1
            }

            return matches == lookup
        }

        let directions: [(Int, Int)] = [
            (0, 1),
            (0, -1),
            (1, 0),
            (-1, 0),
            (1, 1),
            (-1, -1),
            (1, -1),
            (-1, 1),
        ]

        for (rowIndex, row) in matrix.enumerated() {
            for (colIndex, char) in row.enumerated() where char == lookup.first {
                for direction in directions {
                    if lookupInDirection(rowIndex: rowIndex, colIndex: colIndex, direction: direction) {
                        sum += 1
                    }
                }
            }
        }

        return sum
    }

    func part2() -> Int {
        let lookup: [Character] = ["M", "A", "S"]

        var matrix: [[Character]] = []
        var sum = 0

        for entry in entries {
            matrix.append(Array(entry))
            print(Array(entry))
        }

        let rowLimit = matrix.count
        let colLimit = matrix.first?.count ?? 0

        func lookupInDirection(rowIndex: Int, colIndex: Int, direction: (Int, Int)) -> Bool {
            var matches: [Character] = []

            var currentRow = rowIndex
            var currentCol = colIndex

            for char in lookup {
                guard currentRow >= 0, currentRow < rowLimit, currentCol >= 0, currentCol < colLimit else {
                    return false
                }

                if matrix[currentRow][currentCol] == char {
                    matches.append(char)
                } else {
                    return false
                }

                
                currentRow += direction.0
                currentCol += direction.1
            }

            return matches == lookup
        }
        
        let directions = [
            (1, 1),
            (1, -1),
            (-1, 1),
            (-1, -1)
        ]

        for (rowIndex, row) in matrix.enumerated() {
            for (colIndex, char) in row.enumerated() where char == lookup[1] {
                let results = [
                    lookupInDirection(rowIndex: rowIndex - 1, colIndex: colIndex - 1, direction: directions[0]),
                    lookupInDirection(rowIndex: rowIndex - 1, colIndex: colIndex + 1, direction: directions[1]),
                    lookupInDirection(rowIndex: rowIndex + 1, colIndex: colIndex - 1, direction: directions[2]),
                    lookupInDirection(rowIndex: rowIndex + 1, colIndex: colIndex + 1, direction: directions[3]),
                ]
                
                if results.filter({$0}).count == 2 {
                    sum += 1
                }
            }
        }
        
        return sum
    }
}

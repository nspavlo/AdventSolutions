//
//  Day06.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 22/12/2023.
//

import Foundation

struct Day06: Day {
    let dayNumber = 6
    let entries = Input.entriesFromTextFile(named: "Day06")

    func part1() -> Int {
        enum Direction: Character, CaseIterable {
            case up = "^"
            case right = ">"
            case down = "v"
            case left = "<"

            var vector: (x: Int, y: Int) {
                switch self {
                case .up:
                    return (0, -1)
                case .right:
                    return (1, 0)
                case .down:
                    return (0, 1)
                case .left:
                    return (-1, 0)
                }
            }

            func turned() -> Direction {
                switch self {
                case .up:
                    return .right
                case .right:
                    return .down
                case .down:
                    return .left
                case .left:
                    return .up
                }
            }
        }

        var matrix = entries.map { Array($0) }
        var position = (x: 0, y: 0)
        var direction: Direction = .up

        for (y, row) in matrix.enumerated() {
            if let x = row.firstIndex(where: { Direction(rawValue: $0) != nil }) {
                direction = Direction(rawValue: row[x]) ?? direction
                position = (x, y)
                break
            }
        }

        let kVisited: Character = "X"
        let kObstacle: Character = "#"
        let kFreeSpace: Character = "."

        var count = 0
        while true {
            let (x, y) = direction.vector
            let nextPosition = (x: position.x + x, y: position.y + y)

            if nextPosition.x < 0 || nextPosition.y < 0 || nextPosition.x >= matrix[0].count || nextPosition.y >= matrix.count {
                matrix[position.y][position.x] = kVisited
                count += 1
                break
            }

            let nextLocation = matrix[nextPosition.y][nextPosition.x]
            switch nextLocation {
            case kFreeSpace:
                matrix[position.y][position.x] = kVisited
                matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                position = nextPosition
                count += 1

            case kVisited:
                matrix[position.y][position.x] = kVisited
                matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                position = nextPosition

            case kObstacle:
                direction = direction.turned()

            default:
                break
            }
        }

        return 1
    }

    func part2() -> Int {
        return 2
    }
}

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

    enum Tile {
        static let visited: Character = "X"
        static let obstacle: Character = "#"
        static let free: Character = "."
    }

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

    struct Position: Hashable {
        let x: Int
        let y: Int
    }

    func part1() -> Int {
        var matrix = entries.map { Array($0) }
        var position = Position(x: 0, y: 0)
        var direction: Direction = .up

        for (y, row) in matrix.enumerated() {
            if let x = row.firstIndex(where: { Direction(rawValue: $0) != nil }) {
                direction = Direction(rawValue: row[x]) ?? direction
                position = Position(x: x, y: y)
                break
            }
        }

        var count = 0
        while true {
            let (x, y) = direction.vector
            let nextPosition = Position(x: position.x + x, y: position.y + y)

            if nextPosition.x < 0 || nextPosition.y < 0 || nextPosition.x >= matrix[0].count || nextPosition.y >= matrix.count {
                matrix[position.y][position.x] = Tile.visited
                count += 1
                break
            }

            let nextLocation = matrix[nextPosition.y][nextPosition.x]
            switch nextLocation {
            case Tile.free:
                matrix[position.y][position.x] = Tile.visited
                matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                position = nextPosition
                count += 1

            case Tile.visited:
                matrix[position.y][position.x] = Tile.visited
                matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                position = nextPosition

            case Tile.obstacle:
                direction = direction.turned()

            default:
                break
            }
        }

        return count
    }

    func part2() -> Int {
        var matrix = entries.map { Array($0) }
        let initialMatrix = matrix

        var position = Position(x: 0, y: 0)
        var direction: Direction = .up

        for (y, row) in matrix.enumerated() {
            if let x = row.firstIndex(where: { Direction(rawValue: $0) != nil }) {
                direction = Direction(rawValue: row[x]) ?? direction
                position = Position(x: x, y: y)
                break
            }
        }

        let initialPosition = position
        let initialDirection = direction

        var availablePositions: [Position] = []

        while true {
            let (x, y) = direction.vector
            let nextPosition = Position(x: position.x + x, y: position.y + y)

            if nextPosition.x < 0 || nextPosition.y < 0 || nextPosition.x >= matrix[0].count || nextPosition.y >= matrix.count {
                matrix[position.y][position.x] = Tile.visited
                break
            }

            let nextLocation = matrix[nextPosition.y][nextPosition.x]
            switch nextLocation {
            case Tile.free:
                matrix[position.y][position.x] = Tile.visited
                matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                position = nextPosition
                availablePositions.append(.init(x: position.x, y: position.y))

            case Tile.visited:
                matrix[position.y][position.x] = Tile.visited
                matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                position = nextPosition

            case Tile.obstacle:
                direction = direction.turned()

            default:
                break
            }
        }

        var count = 0
        positionLoop: while !availablePositions.isEmpty {
            matrix = initialMatrix
            position = initialPosition
            direction = initialDirection

            let experimentalObstaclePosition = availablePositions.removeLast()
            matrix[experimentalObstaclePosition.y][experimentalObstaclePosition.x] = Tile.obstacle

            var visitedPositions: [Position: Direction] = [:]
            traversalLoop: while true {
                let (x, y) = direction.vector
                let nextPosition = Position(x: position.x + x, y: position.y + y)

                if nextPosition.x < 0 || nextPosition.y < 0 || nextPosition.x >= matrix[0].count || nextPosition.y >= matrix.count {
                    matrix[position.y][position.x] = Tile.visited
                    break traversalLoop
                }

                let nextLocation = matrix[nextPosition.y][nextPosition.x]
                switch nextLocation {
                case Tile.free:
                    matrix[position.y][position.x] = Tile.visited
                    matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                    position = nextPosition

                case Tile.visited:
                    let alreadyVisitedPositionsDirection = visitedPositions[nextPosition]
                    if let alreadyVisitedPositionsDirection, alreadyVisitedPositionsDirection == direction {
                        count += 1
                        break traversalLoop
                    }

                    matrix[position.y][position.x] = Tile.visited
                    matrix[nextPosition.y][nextPosition.x] = direction.rawValue
                    position = nextPosition
                    visitedPositions[nextPosition] = direction

                case Tile.obstacle:
                    direction = direction.turned()

                default:
                    break traversalLoop
                }
            }
        }

        return count
    }
}

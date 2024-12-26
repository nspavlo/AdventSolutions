//
//  Day07.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 22/12/2023.
//

import Foundation

struct Day07: Day {
    let dayNumber = 7
    let entries = Input.entriesFromTextFile(named: "Day07")

    func part1() -> Int {
        let operators = ["+", "*"]

        func generateExpressions(numbers: [String], operators: [String]) -> [[String]] {
            if numbers.count == 1 {
                return [numbers]
            }

            var expressions: [[String]] = []
            for operation in operators {
                guard let firstNumber = numbers.first else { fatalError("Numbers array is unexpectedly empty.") }

                let remainingNumbers = Array(numbers.dropFirst())
                for subExpression in generateExpressions(numbers: remainingNumbers, operators: operators) {
                    expressions.append([firstNumber, operation] + subExpression)
                }
            }

            return expressions
        }

        func evaluateExpressions(expressions: [[String]], result: Int) -> Int? {
            for expression in expressions {
                var sum = 0
                var operation: String?

                for token in expression {
                    switch token {
                    case "+", "*":
                        operation = token
                    default:
                        guard let number = Int(token) else { fatalError() }

                        if sum == 0 {
                            sum = number
                        } else if let operation {
                            switch operation {
                            case "+":
                                sum += number
                            case "*":
                                sum *= number
                            default:
                                fatalError("Unknown operation \(operation)")
                            }
                        }
                    }
                }

                if sum == result {
                    return sum
                }
            }

            return nil
        }

        var sum = 0
        for entry in entries {
            let split = entry.split(separator: ":")
            if let first = split.first, let result = Int(first), let numbers = split.last?.split(separator: " ").map(String.init) {
                let expressions = generateExpressions(numbers: numbers, operators: operators)
                if let result = evaluateExpressions(expressions: expressions, result: result) {
                    sum += result
                }
            }
        }

        print("SUM: \(sum)")

        return sum
    }

    func part2() -> Int {
        return 2
    }
}

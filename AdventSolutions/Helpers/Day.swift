//
//  Day.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 01/12/2022.
//

enum Part: Int {
    case one = 1
    case two = 2
}

protocol Day {
    var dayNumber: Int { get }

    func part1() -> Int
    func part2() -> Int
}

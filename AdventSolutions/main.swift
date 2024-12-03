//
//  main.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 01/12/2022.
//

let days: [Day] = [
    Day01(),
    Day02(),
    Day03(),
]

for day in days {
    let dayString = "Day #\(day.dayNumber)"
    measure(name: "\(dayString), Part #1") { _ = day.part1() }
    measure(name: "\(dayString), Part #2") { _ = day.part2() }
}

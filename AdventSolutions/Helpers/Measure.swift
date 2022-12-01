//
//  Measure.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 01/12/2022.
//

import CoreFoundation

func measure(name: String, closure: () -> Void) {
    let startAbsoluteTime = CFAbsoluteTimeGetCurrent()
    closure()
    let elapsedAbsoluteTime = CFAbsoluteTimeGetCurrent() - startAbsoluteTime
    print("\(name) took: \(elapsedAbsoluteTime)s")
}

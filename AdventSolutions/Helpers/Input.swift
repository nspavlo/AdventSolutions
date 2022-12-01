//
//  Input.swift
//  AdventSolutions
//
//  Created by Jans Pavlovs on 01/12/2022.
//

import Foundation

enum Input {
    static func entriesFromTextFile(named resourceName: String) -> [String] {
        guard let url = Bundle.main.path(forResource: resourceName, ofType: "txt") else {
            fatalError("Failed to locate \(resourceName) in bundle.")
        }

        do {
            let content = try String(contentsOfFile: url, encoding: .utf8)
            return content.components(separatedBy: .newlines)
        } catch {
            fatalError("Error reading contents of file: \(error)")
        }
    }
}

//
//  Operation.swift
//  RxCalculator
//
//  Created by adam tecle on 3/25/18.
//  Copyright © 2018 Adam Tecle. All rights reserved.
//

import Foundation

enum Operation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case equals = "="
    case clear
}

extension Operation: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}

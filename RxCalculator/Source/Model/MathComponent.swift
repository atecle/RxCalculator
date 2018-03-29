//
//  MathComponent.swift
//  RxCalculator
//
//  Created by adam tecle on 3/25/18.
//  Copyright © 2018 Adam Tecle. All rights reserved.
//

import Foundation

enum MathComponent {
    case number(Int)
    case operation(Operation)
}

extension MathComponent: CustomStringConvertible {
    var description: String {
        switch self {
        case .number(let x):
            return "\(x)"
        case .operation(let operation):
            return "\(operation)"
        }
    }
    
    
    
}

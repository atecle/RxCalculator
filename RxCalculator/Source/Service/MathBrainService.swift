//
//  MathBrainService.swift
//  RxCalculator
//
//  Created by adam tecle on 3/25/18.
//  Copyright © 2018 Adam Tecle. All rights reserved.
//

import Foundation

import RxSwift

protocol MathBrainServiceType {
    func evaluate(_ mathComponent: MathComponent) -> String
}

final class MathBrainService: MathBrainServiceType {
        
    var input: [MathComponent] = []
    
    func evaluate(_ mathComponent: MathComponent) -> String {
        switch mathComponent {
        case .number(_):
            input.append(mathComponent)
            return lastDigitsEntered(input)
        case .operation(let operation):
            switch operation {
            case .equals:
                return doMath()
            case .clear:
                input.removeAll()
                return "0"
            default:
                input.append(mathComponent)
                return "\(operation)"
            }
        }
    }
    
    private func doMath() -> String {
        let expressionString = input.reduce("") { "\($0)" + "\($1)"}
        let expression = NSExpression(format: expressionString)
        guard let value = expression.expressionValue(with: nil, context: nil) as? Int else {
            return ""
        }
        
        input.removeAll()
        return String(describing: value)
    }
    
    private func lastDigitsEntered(_ mathComponents: [MathComponent]) -> String {
        var displayString = ""
        outer: for component in mathComponents.reversed() {
            switch component {
            case .number(let x):
                displayString = "\(x)\(displayString)"
            case .operation(_):
                break outer
            }
        }
        
        return displayString
    }
    
}

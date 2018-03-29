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
    
    let shouldEvaluate = { (components: [MathComponent]) -> Bool in
        switch components.last {
        case .some(.operation(.equals)):
            return true
        default:
            return false
        }
    }
    
    var input: [MathComponent] = []
    
    func evaluate(_ mathComponent: MathComponent) -> String {
        switch mathComponent {
        case .number(_):
            input.append(mathComponent)
            return lastDigitsEntered(input)
        case .operation(let op):
            if op == .equals {
               return doMath()
            } else {
                input.append(mathComponent)
                return "\(op)"
            }
        }
    }
    
    private func doMath() -> String {
        let expressionString = input.reduce("") { "\($0)" + "\($1)"}
        let expression = NSExpression(format: expressionString)
        guard let value = expression.expressionValue(with: nil, context: nil) as? Int else {
            return ""
        }
        
        input = []
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

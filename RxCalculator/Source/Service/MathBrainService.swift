//
//  MathBrainService.swift
//  RxCalculator
//
//  Created by adam tecle on 3/25/18.
//  Copyright © 2018 Adam Tecle. All rights reserved.
//

import Foundation

import Expression
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
        let expression = Expression(expressionString)
        
        let display: String
        if let value = try? expression.evaluate() {
            display = String(describing: Int(value))
        } else {
            display = "Error"
        }
        
        input.removeAll()
        return display
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

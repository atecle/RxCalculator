//
//  CalculatorViewReactor.swift
//  RxCalculator
//
//  Created by adam tecle on 3/25/18.
//  Copyright © 2018 Adam Tecle. All rights reserved.
//

import Foundation

import ReactorKit
import RxSwift

final class CalculatorViewReactor: Reactor {
    
    enum Action {
        case apply(MathComponent)
    }
    
    enum Mutation {
        case setDisplayString(String)
    }
    
    struct State {
        var displayString: String
    }
    
    let provider: ServiceProviderType
    let initialState: State
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        self.initialState = State(displayString: "")
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .apply(let mathComponent):
            let shouldEvaluate = { (components: [MathComponent]) -> Bool in
                switch components.last {
                case .some(.operation(.equals)):
                    return true
                default:
                    return false
                }
            }
            
            return Observable.of(mathComponent)
                .scan([MathComponent]()) { (accumulated, new) -> [MathComponent] in
                    var accumulated = accumulated
                    accumulated.append(new)
                    return accumulated
                }
                .filter { shouldEvaluate($0) }
                .map { [weak self] in
                    self?.provider.mathService.evaluate($0) ?? 0
                }.map { Mutation.setDisplayString(String(describing: $0)) }
        }
        
    }
    
    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> CalculatorViewReactor.State {
        var state = state
        switch mutation {
        case .setDisplayString(let displayString):
            state.displayString = displayString
        }
        
        return state
    }
}

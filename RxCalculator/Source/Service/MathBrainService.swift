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
    
    func evaluate(_ mathComponents: [MathComponent]) -> Int
}

final class MathBrainService: MathBrainServiceType {
    
    func evaluate(_ mathComponents: [MathComponent]) -> Int {
        return 0
    }
    
}

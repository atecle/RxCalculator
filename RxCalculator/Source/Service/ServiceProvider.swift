//
//  ServiceProvider.swift
//  TypingGame
//
//  Created by adam tecle on 3/24/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

protocol ServiceProviderType: class {
    var mathService: MathBrainServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var mathService: MathBrainServiceType = MathBrainService()
}


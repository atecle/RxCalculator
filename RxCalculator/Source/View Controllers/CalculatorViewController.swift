//
//  ViewController.swift
//  RxCalculator
//
//  Created by adam tecle on 3/25/18.
//  Copyright © 2018 Adam Tecle. All rights reserved.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit

final class CalculatorViewController: BaseViewController, View {

    typealias Reactor = CalculatorViewReactor
    
    struct Font {
       static let display = UIFont.systemFont(ofSize: 28)
    }
    
    private let zeroButton: UIButton = CalculatorViewController.createButton(title: "0")
    private let oneButton: UIButton = CalculatorViewController.createButton(title: "1")
    private let twoButton: UIButton = CalculatorViewController.createButton(title: "2")
    private let threeButton: UIButton = CalculatorViewController.createButton(title: "3")
    private let fourButton: UIButton = CalculatorViewController.createButton(title: "4")
    private let fiveButton: UIButton = CalculatorViewController.createButton(title: "5")
    private let sixButton: UIButton = CalculatorViewController.createButton(title: "6")
    private let sevenButton: UIButton = CalculatorViewController.createButton(title: "7")
    private let eightButton: UIButton = CalculatorViewController.createButton(title: "8")
    private let nineButton: UIButton = CalculatorViewController.createButton(title: "9")
    
    private let addButton: UIButton = CalculatorViewController.createButton(title: "+")
    private let subtractButton: UIButton = CalculatorViewController.createButton(title: "-")
    private let multiplyButton: UIButton = CalculatorViewController.createButton(title: "*")
    private let equalsButton: UIButton = CalculatorViewController.createButton(title: "=")
    
    private let contentContainerView: UIView = CalculatorViewController.createContentContainerView()
    private static func createContentContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        return view
    }
    
    private let operatorContainerView: UIView = CalculatorViewController.createOperatorContainerView()
    private static func createOperatorContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        return view
    }
    
    private let numberContainerView: UIView = CalculatorViewController.createNumberContainerView()
    private static func createNumberContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        return view
    }
    
    private let displayLabel: UILabel = CalculatorViewController.createDisplayLabel()
    private static func createDisplayLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.font = Font.display
        return label
    }
    
    private static func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Font.display
        return button
    }
    
    init(reactor: Reactor) {
        super.init()
        self.reactor = reactor
        setupView()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func bind(reactor: CalculatorViewController.Reactor) {
        zeroButton.rx.tap
            .map { .apply(.number(0)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        oneButton.rx.tap
            .map { .apply(.number(1)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        twoButton.rx.tap
            .map { .apply(.number(2)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        threeButton.rx.tap
            .map { .apply(.number(3)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        fourButton.rx.tap
            .map { .apply(.number(4)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        fiveButton.rx.tap
            .map { .apply(.number(5)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        sixButton.rx.tap
            .map { .apply(.number(6)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        sevenButton.rx.tap
            .map { .apply(.number(7)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        eightButton.rx.tap
            .map { .apply(.number(8)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        nineButton.rx.tap
            .map { .apply(.number(9)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        addButton.rx.tap
            .map { .apply(.operation(.add)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        subtractButton.rx.tap
            .map { .apply(.operation(.subtract)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        multiplyButton.rx.tap
            .map { .apply(.operation(.multiply)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        equalsButton.rx.tap
            .map { .apply(.operation(.equals)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.asObservable()
            .map { $0.displayString }
            .subscribe(onNext: { [weak self] in
                self?.displayLabel.text = $0
            }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.addSubview(displayLabel)
        view.addSubview(contentContainerView)
        contentContainerView.addSubview(operatorContainerView)
        contentContainerView.addSubview(numberContainerView)
        numberContainerView.addSubview(zeroButton)
        numberContainerView.addSubview(oneButton)
        numberContainerView.addSubview(twoButton)
        numberContainerView.addSubview(threeButton)
        numberContainerView.addSubview(fourButton)
        numberContainerView.addSubview(fiveButton)
        numberContainerView.addSubview(sixButton)
        numberContainerView.addSubview(sevenButton)
        numberContainerView.addSubview(eightButton)
        numberContainerView.addSubview(nineButton)
        operatorContainerView.addSubview(addButton)
        operatorContainerView.addSubview(subtractButton)
        operatorContainerView.addSubview(multiplyButton)
        operatorContainerView.addSubview(equalsButton)
    }
    
    override func setupConstraints() {
        displayLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(-14)
        }
        contentContainerView.snp.makeConstraints {
            $0.top.equalTo(displayLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        numberContainerView.snp.makeConstraints {
            $0.leading.top.bottom.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
        operatorContainerView.snp.makeConstraints {
            $0.leading.equalTo(numberContainerView.snp.trailing)
            $0.bottom.trailing.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        oneButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        twoButton.snp.makeConstraints {
            $0.leading.equalTo(oneButton.snp.trailing)
            $0.top.equalTo(oneButton)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        threeButton.snp.makeConstraints {
            $0.leading.equalTo(twoButton.snp.trailing)
            $0.top.equalTo(oneButton)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        fourButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(oneButton.snp.bottom)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        fiveButton.snp.makeConstraints {
            $0.leading.equalTo(fourButton.snp.trailing)
            $0.top.equalTo(fourButton)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        sixButton.snp.makeConstraints {
            $0.leading.equalTo(fiveButton.snp.trailing)
            $0.top.equalTo(fourButton)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        sevenButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(fourButton.snp.bottom)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        eightButton.snp.makeConstraints {
            $0.leading.equalTo(sevenButton.snp.trailing)
            $0.top.equalTo(sevenButton)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        nineButton.snp.makeConstraints {
            $0.leading.equalTo(eightButton.snp.trailing)
            $0.top.equalTo(sevenButton)
            $0.width.equalToSuperview().multipliedBy(0.33333)
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        zeroButton.snp.makeConstraints {
            $0.top.equalTo(sevenButton.snp.bottom)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        subtractButton.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        multiplyButton.snp.makeConstraints {
            $0.top.equalTo(subtractButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        equalsButton.snp.makeConstraints {
            $0.top.equalTo(multiplyButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        
    }

}


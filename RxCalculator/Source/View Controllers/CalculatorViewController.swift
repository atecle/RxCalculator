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
       static let display = UIFont.systemFont(ofSize: 40)
       static let displayLarge = UIFont.systemFont(ofSize: 60)
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
    
    private let clearButton: UIButton = CalculatorViewController.createButton(title: "C", backgroundColor: .orange)
    private let addButton: UIButton = CalculatorViewController.createButton(title: "+", backgroundColor: .orange)
    private let subtractButton: UIButton = CalculatorViewController.createButton(title: "-", backgroundColor: .orange)
    private let multiplyButton: UIButton = CalculatorViewController.createButton(title: "*", backgroundColor: .orange)
    private let equalsButton: UIButton = CalculatorViewController.createButton(title: "=", backgroundColor: .orange)
    private lazy var buttons: [UIButton] = {
        return [zeroButton, oneButton, twoButton, threeButton,
                fourButton, fiveButton, sixButton, eightButton,
                nineButton, multiplyButton, subtractButton, equalsButton]
    }()
    
    private let contentContainerView: UIView = CalculatorViewController.createContentContainerView()
    private static func createContentContainerView() -> UIView {
        let view = UIView()
        return view
    }
    
    private let operatorContainerView: UIView = CalculatorViewController.createOperatorContainerView()
    private static func createOperatorContainerView() -> UIView {
        let view = UIView()
        return view
    }
    
    private let numberContainerView: UIView = CalculatorViewController.createNumberContainerView()
    private static func createNumberContainerView() -> UIView {
        let view = UIView()
        return view
    }
    
    private let displayLabel: UILabel = CalculatorViewController.createDisplayLabel()
    private static func createDisplayLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = Font.displayLarge
        return label
    }
    
    private static func createButton(title: String, backgroundColor: UIColor? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.clipsToBounds = true
        button.titleLabel?.font = Font.display
        return button
    }
    
    init(reactor: Reactor) {
        super.init()
        self.reactor = reactor
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: CalculatorViewController.Reactor) {
        /// Send load action on start up
        Observable.just(Reactor.Action.load)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        /// Bind button taps
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
        clearButton.rx.tap
            .map { .apply(.operation(.clear)) }
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
        
        /// Subscribe to changes in state and modify view
        reactor.state.asObservable()
            .map { $0.displayString }
            .subscribe(onNext: { [weak self] in
                self?.displayLabel.text = $0
            }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.backgroundColor = .black
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
        operatorContainerView.addSubview(clearButton)
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
        
        clearButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        addButton.snp.makeConstraints {
            $0.top.equalTo(clearButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        subtractButton.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        multiplyButton.snp.makeConstraints {
            $0.top.equalTo(subtractButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        equalsButton.snp.makeConstraints {
            $0.top.equalTo(multiplyButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
    }

}


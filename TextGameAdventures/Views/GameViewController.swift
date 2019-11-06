//
//  GameViewController.swift
//  TextGameAdventures
//
//  Created by James Furlong on 30/10/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIButton {
    func setTitleAndBackgroundColor(_ titleColor: UIColor, backgroundColor: UIColor, for state: UIControlState) {
        self.setTitleColor(titleColor, for: state)
        self.setBackgroundImage(backgroundColor.toImage(), for: state)
        self.layer.borderColor = UIColor.white.cgColor
    }
}

class GameViewController: UIViewController {
    private let viewModel: GameViewModel = GameViewModel()
    private let disposeBag: DisposeBag = DisposeBag()

    // MARK: - UI
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        
        UserDefaults.standard.rx.observe(String.self, "playerName")
            .subscribe(onNext: { [weak self] (playerName) in
                if let playerName = playerName {
                    label.text = playerName
                }
            })
        .disposed(by: disposeBag)
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status"
        label.textColor = UIColor.white
        
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        
        return label
    }()
    
    lazy var upButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("U", for: .normal)
        button.layer.borderWidth = 2
        
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.darkGray, for: .disabled)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.lightGray, for: .normal)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.purple, for: .selected)
        
        button.addTarget(self, action: #selector(setButtonSelected(_:)), for: .touchUpInside)
        
        button.rx.tap
            .subscribe(onNext: { self.viewModel.upSelected.value = !self.viewModel.upSelected.value })
            .disposed(by: disposeBag)
        
        viewModel.upSelected
            .asObservable()
            .bind(to: button.rx.isSelected)
            .disposed(by: disposeBag)
        
        viewModel.upButtonEnabled
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("L", for: .normal)
        button.layer.borderWidth = 2

        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.darkGray, for: .disabled)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.lightGray, for: .normal)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.purple, for: .selected)
        
        button.addTarget(self, action: #selector(setButtonSelected(_:)), for: .touchUpInside)
    
        button.rx.tap
            .subscribe(onNext: { self.viewModel.leftSelected.value = !self.viewModel.leftSelected.value })
            .disposed(by: disposeBag)
        
        viewModel.leftSelected
            .asObservable()
            .bind(to: button.rx.isSelected)
            .disposed(by: disposeBag)
        
        viewModel.leftButtonEnabled
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)

        return button
    }()
    
    lazy var downButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("D", for: .normal)
        button.layer.borderWidth = 2
        
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.darkGray, for: .disabled)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.lightGray, for: .normal)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.purple, for: .selected)
        
        button.addTarget(self, action: #selector(setButtonSelected(_:)), for: .touchUpInside)

        button.rx.tap
            .subscribe(onNext: {self.viewModel.downSelected.value = !self.viewModel.downSelected.value})
            .disposed(by: disposeBag)
        
        viewModel.downSelected
            .asObservable()
            .bind(to: button.rx.isSelected)
            .disposed(by: disposeBag)
         
        
        viewModel.downButtonEnabled
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
  
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("R", for: .normal)
        button.layer.borderWidth = 2
        
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.darkGray, for: .disabled)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.lightGray, for: .normal)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.purple, for: .selected)
        
        button.addTarget(self, action: #selector(setButtonSelected(_:)), for: .touchUpInside)
        
        button.rx.tap
            .subscribe(onNext: {self.viewModel.rightSelected.value = !self.viewModel.rightSelected.value})
            .disposed(by: disposeBag)
        
        viewModel.rightSelected
            .asObservable()
            .bind(to: button.rx.isSelected)
            .disposed(by: disposeBag)
        
        viewModel.rightButtonEnabled
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)

        return button
    }()
    
    lazy var actionButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ACTION", for: .normal)
        button.layer.borderWidth = 2
        
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.darkGray, for: .disabled)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.lightGray, for: .normal)
        button.setTitleAndBackgroundColor(UIColor.white, backgroundColor: UIColor.purple, for: .highlighted)
        
        button.addTarget(self, action: #selector(playerAction(_:)), for: .touchUpInside)
        
        button.rx.tap
            .subscribe(onNext: {self.viewModel.actionSelected.value = !self.viewModel.actionSelected.value})
            .disposed(by: disposeBag)
        
        viewModel.actionButtonSelected
            .bind(to: button.rx.isSelected)
            .disposed(by: disposeBag)
        
        viewModel.actionButtonEnabled
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.addSubview(descLabel)
        view.addSubview(upButton)
        view.addSubview(leftButton)
        view.addSubview(downButton)
        view.addSubview(rightButton)
        view.addSubview(actionButton)
        
        setupLayout()
        setupBindings()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            statusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            actionButton.heightAnchor.constraint(equalToConstant: 60),
            actionButton.widthAnchor.constraint(equalToConstant: 250),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            downButton.widthAnchor.constraint(equalToConstant: 50),
            downButton.heightAnchor.constraint(equalToConstant: 50),
            downButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downButton.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -20),
            leftButton.widthAnchor.constraint(equalToConstant: 50),
            leftButton.heightAnchor.constraint(equalToConstant: 50),
            leftButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            leftButton.bottomAnchor.constraint(equalTo: downButton.topAnchor, constant: -20),
            rightButton.widthAnchor.constraint(equalToConstant: 50),
            rightButton.heightAnchor.constraint(equalToConstant: 50),
            rightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            rightButton.bottomAnchor.constraint(equalTo: downButton.topAnchor, constant: -20),
            upButton.widthAnchor.constraint(equalToConstant: 50),
            upButton.heightAnchor.constraint(equalToConstant: 50),
            upButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upButton.bottomAnchor.constraint(equalTo: rightButton.topAnchor, constant: -20)
        ])
    }
    
    func setupBindings() {
        viewModel.currentPosition
            .subscribe({ (value) in
                print("current position: ", value)
            })
            .disposed(by: disposeBag)

        viewModel.actionButtonSelected
            .subscribe({ value in
                if (value.element ?? true) {
                    print("setting to false: ")
                    self.viewModel.upSelected.value = false
                    self.viewModel.downSelected.value = false
                    self.viewModel.rightSelected.value = false
                    self.viewModel.leftSelected.value = false
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isGameFinished
            .subscribe({ (value) in
                if (value.element ?? false) {
                    print("GAME OVER: ", value)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Button Functions
    
    @objc func setButtonSelected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func playerAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if (viewModel.upSelected.value) {
            viewModel.setCurrentPosition(direction: 1)
        }
        else if (viewModel.downSelected.value) {
            viewModel.setCurrentPosition(direction: 2)
        }
        else if (viewModel.rightSelected.value) {
            viewModel.setCurrentPosition(direction: 3)
        }
        else if (viewModel.leftSelected.value) {
            viewModel.setCurrentPosition(direction: 4)
        }
    }
}

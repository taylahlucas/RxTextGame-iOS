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

class GameViewController: UIViewController {
    private let viewModel: GameViewModel = GameViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - UI
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var upButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("UP", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        
        button.rx.tap
            .bind(to: viewModel.upButtonTapped)
            .disposed(by: disposeBag)
        
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LEFT", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
    
        button.rx.tap
            .bind(to: viewModel.leftButtonTapped)
            .disposed(by: disposeBag)
        

        return button
    }()
    
    lazy var downButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("DOWN", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        
        button.rx.tap
            .bind(to: viewModel.downButtonTapped)
            .disposed(by: disposeBag)
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("RIGHT", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        
        button.rx.tap
            .bind(to: viewModel.rightButtonTapped)
            .disposed(by: disposeBag)
        
        return button
    }()
    
    lazy var actionButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ACTION", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        
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
        setupBinding()
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
    
    // MARK: - Binding
    
    private func setupBinding() {
        viewModel.description
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] description in
                self?.descLabel.text = description
            })
            .disposed(by: disposeBag)
    }
}

//
//  StartPageViewController.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 30/10/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StartPageViewController: UIViewController {
    private let viewModel: GameViewModel = GameViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let mainStack: UIStackView = {
        let view: UIStackView = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        view.spacing = 20
        
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter Name: "
        label.textColor = UIColor.white
        
        return label
    }()
    
    private lazy var nameField: UITextField = {
        let input: UITextField = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.backgroundColor = UIColor.white
        input.borderStyle = .roundedRect
        input.placeholder = "Name"
        input.returnKeyType = .done

        input.rx.text
            .orEmpty
            .asObservable()
            .bind(to: viewModel.playerNameEntered)
            .disposed(by: disposeBag)

        return input
    }()
    
    private lazy var startButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Game", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupBinding()
    }
    
    func setupLayout() {
        view.backgroundColor = UIColor.darkGray
        
        view.addSubview(mainStack)
        
        mainStack.addArrangedSubview(nameLabel)
        mainStack.addArrangedSubview(nameField)
        mainStack.addArrangedSubview(startButton)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mainStack.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 72),

            nameField.widthAnchor.constraint(equalToConstant: 300),
            nameField.heightAnchor.constraint(equalToConstant: 60),

            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 72),
        ])
    }
    
    func setupBinding() {
        viewModel.playerName
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] playerName in
                self?.nameField.text = playerName
            })
            .disposed(by: disposeBag)
    }
    
    @objc func startGame() {
        print("starting game")
    }
    
    @objc func nameEntered() {
        print("name entered")
    }
}

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

extension UIColor {
   func toImage() -> UIImage {
       let bounds: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
       let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(bounds: bounds)
       return renderer.image { rendererContext in
           rendererContext.cgContext.setFillColor(self.cgColor)
           rendererContext.cgContext.fill(bounds)
       }
   }
}

class StartPageViewController: UIViewController {
    private let viewModel: StartPageViewModel = StartPageViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - UI
    
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

        input.rx.controlEvent(.allEditingEvents)
            .map { _ in input.text}
            .bind(to: viewModel.playerNameEntered)
            .disposed(by: disposeBag)

        return input
    }()
    
    private lazy var startButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.isEnabled = false
        button.setTitle("Start Game", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.setBackgroundImage(UIColor.toImage(UIColor.lightGray)(), for: .disabled)
        button.setBackgroundImage(UIColor.toImage(UIColor.purple)(), for: .normal)
        button.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        
        viewModel.buttonIsEnabled
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    // MARK: - Functions
    
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

    @objc func startGame(_ sender: UIButton) {
        self.present(GameViewController(), animated: true, completion: nil)
    }
}

//
//  EndGameViewController.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 6/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EndGameViewController: UIViewController {
    let viewModel = EndGameViewModel()
    
    // MARK: - UI

    lazy var mainStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering

        return stack
    }()
    
    lazy var resultLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.resultString
        label.textColor = UIColor.white
        
        return label
    }()
    
    lazy var chestsCollectedLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chests Collected: " + viewModel.chestsCollectedString
        label.textColor = UIColor.white
        
        return label
    }()
    
    lazy var totalChestsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total Chests: " + viewModel.totalChestsString
        label.textColor = UIColor.white
        
        return label
    }()
    
    lazy var playAgainButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        button.setTitle("Play Again?", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.setBackgroundImage(UIColor.toImage(UIColor.lightGray)(), for: .disabled)
        button.setBackgroundImage(UIColor.toImage(UIColor.purple)(), for: .normal)
        
        button.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(resultLabel)
        mainStack.addArrangedSubview(chestsCollectedLabel)
        mainStack.addArrangedSubview(totalChestsLabel)
        mainStack.addArrangedSubview(playAgainButton)
        
        setupLayout()
    }
    
    // MARK: - Layout
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            mainStack.widthAnchor.constraint(equalToConstant: view.frame.width),
            mainStack.heightAnchor.constraint(equalToConstant: 300),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            playAgainButton.widthAnchor.constraint(equalToConstant: 145),
            playAgainButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    // MARK: - Button Functions
    @objc func playAgain() {
        self.dismiss(animated: true, completion: nil)
    }
}

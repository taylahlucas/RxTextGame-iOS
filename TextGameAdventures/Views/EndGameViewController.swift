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
    
    lazy var chestResultStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    lazy var resultLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.resultString
        label.textColor = Color.whiteText.value
        label.font = Font.heading.value
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var chestsCollectedLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chests Collected: " + viewModel.chestsCollectedString
        label.textColor = Color.whiteText.value
        label.font = Font.description.value
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var totalChestsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total Chests: " + viewModel.totalChestsString
        label.textColor = Color.whiteText.value
        label.font = Font.description.value
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var playAgainButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("Play Again?", for: .normal)
        button.titleLabel?.textColor = Color.whiteText.value
        UIScheme.instance.setButtonScheme(for: button)
        button.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Layout
    
    func setupLayout() {
        UIScheme.instance.setViewScheme(for: self)
        
        view.addSubview(mainStack)
        
        chestResultStack.addArrangedSubview(chestsCollectedLabel)
        chestResultStack.addArrangedSubview(totalChestsLabel)
        
        mainStack.addArrangedSubview(resultLabel)
        mainStack.addArrangedSubview(chestResultStack)
        mainStack.addArrangedSubview(playAgainButton)
        
        NSLayoutConstraint.activate([
            chestResultStack.widthAnchor.constraint(equalToConstant: 160),
            chestResultStack.heightAnchor.constraint(equalToConstant: 80),

            mainStack.widthAnchor.constraint(equalToConstant: view.frame.width),
            mainStack.heightAnchor.constraint(equalToConstant: 300),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            playAgainButton.widthAnchor.constraint(equalToConstant: 145),
            playAgainButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    // MARK: - Button Functions
    @objc func playAgain() {
        UIColorScheme.instance.setHighlightedButtonScheme(for: playAgainButton)
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  GameViewModel.swift
//  TextGameAdventures
//
//  Created by James Furlong on 30/10/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import RxSwift
import RxCocoa

class GameViewModel {
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    let gameMap: [[MapObject]] = [
        [.start, .none, .none, .chest],
        [.path, .path, .path, .path],
        [.path, .trap, .path, .none],
        [.path, .none, .path, .trap],
        [.path, .trap, .path, .finish]
    ]
    
    // MARK: - Actions
    
    let upButtonTapped: PublishSubject<Void> = PublishSubject()
    
    // MARK: - Observables
    
    lazy var description: Observable<String> = {
        
        upButtonTapped
            .map { _ in
                //TODO: create the description string to pass through to the VC
                "Up button tapped"
            }
        
    }()
}

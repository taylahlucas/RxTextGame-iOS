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
    let leftButtonTapped: PublishSubject<Void> = PublishSubject()
    let rightButtonTapped: PublishSubject<Void> = PublishSubject()
    let downButtonTapped: PublishSubject<Void> = PublishSubject()
    
    let playerNameEntered: PublishSubject<String> = PublishSubject()
    
    // MARK: - Observables

    lazy var description: Observable<String> = {
        return Observable
            .merge(
                upButtonTapped.map { _ in  "Move Up"},
                downButtonTapped.map { _ in "Move Down"},
                leftButtonTapped.map { _ in "Move Left"},
                rightButtonTapped.map { _ in "Move Right"}
            )
    }()
  
    lazy var playerName: Observable<String> = {
        print("here")
        return playerNameEntered
    }()
    
//https://stackoverflow.com/questions/45234915/uitextfield-binding-to-viewmodel-with-rxswift/45238861
//    func playerNameValid(playerName: Observable<String>) -> Observable<Bool> {
//        return Observable.to(playerName) {
//            (playerName) in
//            return playerName.characters.count > 0
//        }
//    }
}

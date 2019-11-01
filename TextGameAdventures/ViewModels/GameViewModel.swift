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
    
    lazy var maxCol: Int = {
        return self.gameMap[0].count
    }()
    
    lazy var maxRow: Int = {
        return self.gameMap.count
    }()
    
    // MARK: - Actions
    
    let upButtonTapped: PublishSubject<Void> = PublishSubject()
    let leftButtonTapped: PublishSubject<Void> = PublishSubject()
    let rightButtonTapped: PublishSubject<Void> = PublishSubject()
    let downButtonTapped: PublishSubject<Void> = PublishSubject()

    var currentPosition: BehaviorSubject<[Int]> = BehaviorSubject<[Int]>(value: [0, 0])
    
    lazy var upSelected = Variable(false)
    lazy var downSelected = Variable(false)
    lazy var leftSelected = Variable(false)
    lazy var rightSelected = Variable(false)
    
    // MARK: - Observables
    
    lazy var currentPos: Observable<[Int]> = {
        return currentPosition
    }()

//    lazy var canMove: Observable<Bool> = {
//        // If one of these values is true, return true, If ALL of the values are false, return false
//        return Observable
//            .combineLatest(
//                self.upButtonEnabled.map { valid -> Bool in return valid }.startWith(false),
//                self.downButtonEnabled.map { valid -> Bool in return valid }.startWith(false),
//                self.leftButtonEnabled.map { valid -> Bool in return valid }.startWith(false),
//                self.rightButtonEnabled.map { valid -> Bool in return valid }.startWith(false)
//            ) { ($0, $1, $2, $3) }
//            .map { up, down, left, right in
//                if (up || down || left || right) { return true }
//                return false
//            }
//    }()

    // This function return true if one of the buttons is selected
    // Change this to return whichever value is selected instead of boolean ?
    lazy var selectedButtons: Observable<Bool> = {
        return Observable
        .combineLatest(
            self.upSelected.asObservable().map { value in return value }.startWith(false),
            self.downSelected.asObservable().map { value in return value }.startWith(false),
            self.leftSelected.asObservable().map { value in return value }.startWith(false),
            self.rightSelected.asObservable().map { value in return value }.startWith(false)
        ) { ($0, $1, $2, $3) }
            .map { up, down, left, right in
                if (up || down || left || right) { return true }
                return false
        }
    }()
    
    lazy var upButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[0]+1 < self.maxRow) else { return false }
                if (self.getPosValue(position: [position[0]+1, position[1]]) == .path) {
                    return true
                }
                return false
            }
    }()
    
    lazy var leftButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[1]-1 > 0) else { return false }
                if (self.getPosValue(position: [position[0], position[1]-1]) == .path) {
                    return true
                }
                return false
            }
    }()
    
    lazy var downButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[0]-1 > 0) else { return false }
                if (self.getPosValue(position: [position[0]-1, position[1]]) == .path) {
                    return true
                }
                return false
            }
    }()

    lazy var rightButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[1]+1 < self.maxCol) else { return false }
                if (self.getPosValue(position: [position[0], position[1]+1]) == .path) {
                    return true
                }
                return false
            }
    }()

    lazy var actionButtonEnabled: Observable<Bool> = {
        selectedButtons
            .map { allowMove -> Bool in return allowMove }
    }()

    // MARK: - Functions
    
    func getPosValue(position: [Int]) -> MapObject {
        return gameMap[position[0]][position[1]]
    }
    
    func setCurrentPosition(direction: String){
        // TO DO -- Need to update values after map
        if (direction == "up") {
           currentPos.map({ pos in self.gameMap[pos[0]+1][pos[1]]})
        }
        else if (direction == "left") {
            currentPos.map({ pos in self.gameMap[pos[0]][pos[1]-1] })
        }
        

        // not printing??
        currentPos
            .do(onNext: { pos in print("here: ", pos)})
    }
}

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
        return self.gameMap[0].count-1
    }()
    
    lazy var maxRow: Int = {
        return self.gameMap.count-1
    }()
    
    // MARK: - Actions
    
    lazy var upSelected: PublishSubject<Void> = PublishSubject<Void>()
    lazy var downSelected: PublishSubject<Void> = PublishSubject<Void>()
    lazy var leftSelected: PublishSubject<Void> = PublishSubject<Void>()
    lazy var rightSelected: PublishSubject<Void> = PublishSubject<Void>()
    lazy var actionSelected: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Observables
    var selectedButton: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var currentPosition: BehaviorRelay<[Int]> = BehaviorRelay<[Int]>(value: [0, 0])
    
    var upRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var leftRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var downRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var rightRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    // Returns value of 1-4 indicating which direction the player has selected
    lazy var selectedButtons: Observable<Int> = {
        return Observable
            .combineLatest(
                upIsSelected.startWith(false),
                downIsSelected.startWith(false),
                leftIsSelected.startWith(false),
                rightIsSelected.startWith(false)
            ) { ($0, $1, $2, $3) }
            .map { up, down, left, right in
                if (up) { return 1 }
                if (down) { return 2 }
                if (left) { return 3 }
                if (right) { return 4 }
                return 0
            }
            .do(onNext: { [weak self] value in
                self?.selectedButton.accept(value)
            })
    }()
    
    lazy var setCurrentPosition: Observable<Void> = {
        actionSelected
            .withLatestFrom(selectedButton)
            .withLatestFrom(currentPosition) { ($0, $1) }
            .map { [weak self] button, curPos -> Void in

                    switch button {
                    case 1: self?.currentPosition.insert(curPos[0]+1, at: 0)            // up
                    case 2: self?.currentPosition.insert(curPos[0]-1, at: 0)            // down
                    case 3: self?.currentPosition.insert(curPos[1]-1, at: 1)            // left
                    case 4: self?.currentPosition.insert(curPos[1]+1, at: 1)            // right
                    default:
                            self?.currentPosition.insert(curPos[0], at: 0)
                    }
                }
        }()
    
    lazy var upButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                print("up: ", position[0])
                guard (position[0]+1 <= self.maxRow) else { return false }
                let gridType = self.getPosValue(position: [position[0]+1, position[1]])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var upIsSelected: Observable<Bool> = {
        upSelected
            .subscribe({ _ in
                self.upRelay.accept(!self.upRelay.value)
            })
            .disposed(by: disposeBag)
        
        return upRelay.asObservable()
    }()
    
    lazy var leftButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                print("left: ", position[1])
                guard (position[1]-1 >= 0) else { return false }
                let gridType = self.getPosValue(position: [position[0], position[1]-1])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var leftIsSelected: Observable<Bool> = {
        leftSelected
            .subscribe({ _ in
                self.leftRelay.accept(!self.leftRelay.value)
            })
            .disposed(by: disposeBag)
        
        return leftRelay.asObservable()
    }()
    
    lazy var downButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                print("down: ", position[0])
                guard (position[0]-1 >= 0) else { return false }
                let gridType = self.getPosValue(position: [position[0]-1, position[1]])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var downIsSelected: Observable<Bool> = {
        downSelected
            .subscribe({ _ in
                self.downRelay.accept(!self.downRelay.value)
            })
            .disposed(by: disposeBag)
        
        return downRelay.asObservable()
    }()

    lazy var rightButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                print("right: ", position[1])
                guard (position[1]+1 <= self.maxCol) else { return false }
                let gridType = self.getPosValue(position: [position[0], position[1]+1])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var rightIsSelected: Observable<Bool> = {
        rightSelected
            .subscribe({ _ in
                self.rightRelay.accept(!self.rightRelay.value)
            })
            .disposed(by: disposeBag)
        
        return rightRelay.asObservable()
    }()
    
    lazy var actionButtonEnabled: Observable<Bool> = {
        selectedButtons
            .map { allowMove -> Bool in
                if (allowMove > 0) {
                    return true
                }
                return false
        }
    }()
    
    lazy var actionIsSelected: Observable<Bool> = {
        var actionRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        actionSelected
            .subscribe({ _ in
                actionRelay.accept(!actionRelay.value)
            })
            .disposed(by: disposeBag)

        return actionRelay.asObservable()
    }()

    lazy var isGameFinished: Observable<Bool> = {
        currentPosition
            .map{ position -> Bool in
                if (self.getPosValue(position: position) == .finish) {
                    return true
                }
                self.upRelay.accept(false)
                self.leftRelay.accept(false)
                self.downRelay.accept(false)
                self.rightRelay.accept(false)
                return false
            }
    }()
        
    // MARK: - Functions
    
    func getPosValue(position: [Int]) -> MapObject {
        return gameMap[position[0]][position[1]]
    }
}


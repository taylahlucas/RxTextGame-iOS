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
    
    var currentPosition: BehaviorRelay<[Int]> = BehaviorRelay<[Int]>(value: [0, 0])

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
    }()
    
    lazy var upButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[0]+1 <= self.maxRow) else { return false }
                let gridType = self.getPosValue(position: [position[0]+1, position[1]])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var upIsSelected: Observable<Bool> = {
        var upRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        actionSelected
            .subscribe(onNext: { upRelay.accept(false) })
            .disposed(by: disposeBag)
    
        upSelected
            .subscribe({ _ in
                upRelay.accept(!upRelay.value)
            })
            .disposed(by: disposeBag)
        
        return upRelay.asObservable()
    }()
    
    lazy var leftButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[1]-1 >= 0) else { return false }
                let gridType = self.getPosValue(position: [position[0], position[1]-1])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var leftIsSelected: Observable<Bool> = {
        var leftRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        actionSelected
            .subscribe(onNext: { leftRelay.accept(false) })
            .disposed(by: disposeBag)
    
        upSelected
            .subscribe({ _ in
                leftRelay.accept(!leftRelay.value)
            })
            .disposed(by: disposeBag)
        
        return leftRelay.asObservable()
    }()
    
    lazy var downButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[0]-1 >= 0) else { return false }
                let gridType = self.getPosValue(position: [position[0]-1, position[1]])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var downIsSelected: Observable<Bool> = {
        var downRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        actionSelected
            .subscribe(onNext: { downRelay.accept(false) })
            .disposed(by: disposeBag)
    
        upSelected
            .subscribe({ _ in
                downRelay.accept(!downRelay.value)
            })
            .disposed(by: disposeBag)
        
        return downRelay.asObservable()
    }()

    lazy var rightButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[1]+1 <= self.maxCol) else { return false }
                let gridType = self.getPosValue(position: [position[0], position[1]+1])
                if gridType == .path || gridType == .finish {
                    return true
                }
                return false
            }
    }()
    
    lazy var rightIsSelected: Observable<Bool> = {
        var rightRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        actionSelected
            .subscribe(onNext: { rightRelay.accept(false) })
            .disposed(by: disposeBag)
    
        upSelected
            .subscribe({ _ in
                rightRelay.accept(!rightRelay.value)
            })
            .disposed(by: disposeBag)
        
        return rightRelay.asObservable()
    }()
    
    lazy var actionButtonEnabled: Observable<Bool> = {
//        selectedButtons                   // "cannot convert value of type Observable<Int> to closure tpye Observable<Bool>
//            .filter({ $0 > 0 })
        
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
//        currentPosition               // Type [Int] has no member finish
//            .filter({ $0 == .finish })
    
        currentPosition
            .map{ position -> Bool in
                if (self.getPosValue(position: position) == .finish) {
                    return true
                }
                return false
        }
    }()
    
    lazy var moveTo: Observable<Void>  = {
        selectedButtons
            .map { button in
                print("button: ", button)
        }
    }()

    // MARK: - Functions
    
    func getPosValue(position: [Int]) -> MapObject {
        return gameMap[position[0]][position[1]]
    }
    
    func setCurrentPosition(direction: Int) {
        if (direction == 1) {                               // Up
            currentPosition.insert(currentPosition.value[0]+1, at: 0)
        }
        else if (direction == 2) {                          // Down
            currentPosition.insert(currentPosition.value[0]-1, at: 0)
        }
        else if (direction == 3) {                          // Right
            currentPosition.insert(currentPosition.value[1]+1, at: 1)
        }
        else if (direction == 4) {                          // Left
            currentPosition.insert(currentPosition.value[1] - 1, at: 1)
        }
    }
}

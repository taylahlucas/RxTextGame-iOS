//
//  GameViewModel.swift
//  TextGameAdventures
//
//  Created by James Furlong on 30/10/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func insert(_ element: Element.Element, at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        newValue.insert(element, at: index)
        accept(newValue)
    }
    
    func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
}

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

    var currentPosition: BehaviorRelay<[Int]> = BehaviorRelay<[Int]>(value: [0, 0])
    
    lazy var upSelected = Variable(false)
    lazy var downSelected = Variable(false)
    lazy var leftSelected = Variable(false)
    lazy var rightSelected = Variable(false)
    lazy var actionSelected = Variable(false)
    
    // MARK: - Observables

    lazy var selectedButtons: Observable<Int> = {
        return Observable
        .combineLatest(
            self.upSelected.asObservable().map { value in return value }.startWith(false),
            self.downSelected.asObservable().map { value in return value }.startWith(false),
            self.leftSelected.asObservable().map { value in return value }.startWith(false),
            self.rightSelected.asObservable().map { value in return value }.startWith(false)
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
                if (self.getPosValue(position: [position[0]+1, position[1]]) == .path) {
                    return true
                }
                return false
            }
    }()
    
    lazy var leftButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[1]-1 >= 0) else { return false }
                if (self.getPosValue(position: [position[0], position[1]-1]) == .path) {
                    return true
                }
                return false
            }
    }()
    
    lazy var downButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[0]-1 >= 0) else { return false }
                if (self.getPosValue(position: [position[0]-1, position[1]]) == .path) {
                    return true
                }
                return false
            }
    }()

    lazy var rightButtonEnabled: Observable<Bool> = {
        currentPosition
            .map { position -> Bool in
                guard (position[1]+1 <= self.maxCol) else { return false }
                if (self.getPosValue(position: [position[0], position[1]+1]) == .path) {
                    return true
                }
                return false
            }
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
    
    lazy var actionButtonSelected: Observable<Bool> = {
        return actionSelected.asObservable()
    }()

    lazy var isGameFinished: Observable<Bool> = {
        currentPosition
            .map{ position -> Bool in
                if (self.getPosValue(position: position) == .finish) {
                    return true
                }
                return false
        }
    }()
    
    // MARK: - Functions
    
    func getPosValue(position: [Int]) -> MapObject {
        return gameMap[position[0]][position[1]]
    }
    
    func setCurrentPosition(direction: Int) {
        print("direction: ", direction)
        
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

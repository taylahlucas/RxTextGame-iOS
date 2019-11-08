//
//  StartPageViewModel.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 1/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import RxSwift
import RxCocoa

class StartPageViewModel {
    private let disposeBag: DisposeBag = DisposeBag()

    // MARK: - Actions
    
    let playerNameEntered: PublishSubject<String?> = PublishSubject()
    
    // MARK: - Observables
    
    lazy var playerName: Observable<String?> = {
      return playerNameEntered
        .do(onNext: { (playerName) in
            UserDefaults.standard.set(playerName, forKey: "playerName")
        })
    }()

    lazy var buttonIsEnabled: Observable<Bool> = {
      playerName
          .map { name -> Bool in
            return !(name ?? "").isEmpty
          }
    }()
}

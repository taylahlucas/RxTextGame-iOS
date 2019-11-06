//
//  EndGameViewModel.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 6/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import RxSwift
import RxCocoa

class EndGameViewModel {
    let resultString: String = {
       return UserDefaults.standard.string(forKey: "endMessage") ?? ""
    }()
    
    let chestsCollectedString: String = {
        return UserDefaults.standard.string(forKey: "chestsCollected") ?? ""
    }()
    
    let totalChestsString: String = {
        return UserDefaults.standard.string(forKey: "totalChests") ?? ""
    }()
}

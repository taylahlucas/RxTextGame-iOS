//
//  Schemes.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 12/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import UIKit

class UIScheme {
    func setViewScheme(for viewController: UIViewController) {
        UIColorScheme.instance.setViewColourScheme(for: viewController)
    }
   
    func setButtonScheme(for button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5          // or 2
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
        button.clipsToBounds = true
        
        UIColorScheme.instance.setUnselectedButtonScheme(for: button)
    }
    
    static let instance = UIScheme()
}

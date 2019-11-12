//
//  Fonts.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 6/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    struct Fonts {
        static let heading = UIFont(name: "Arial", size: 30)
        static let subHeading = UIFont(name: "Arial", size: 24)
        static let description = UIFont(name: "Arial", size: 18)
    }
}

extension Font {
    var value: UIFont {
        var instanceFont = UIFont.init()

        switch self {
        case .heading:
            instanceFont = UIFont.Fonts.heading!   // How to get around force unwrapping ??
        case .subHeading:
            instanceFont = UIFont.Fonts.subHeading!
        case .description:
            instanceFont = UIFont.Fonts.description!
        }
        
        return instanceFont
    }
}

enum Font {
    case heading
    case subHeading
    case description
}

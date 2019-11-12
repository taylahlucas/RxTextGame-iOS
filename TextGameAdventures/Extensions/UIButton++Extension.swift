//
//  UIButton++Extension.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 8/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIButton {
    func setTitleAndBackgroundColor(_ titleColor: UIColor, backgroundColor: UIColor, for state: UIControlState) {
        self.setTitleColor(titleColor, for: state)
        self.setBackgroundImage(backgroundColor.toImage(), for: state)
        self.layer.borderColor = UIColor.white.cgColor
    }
}

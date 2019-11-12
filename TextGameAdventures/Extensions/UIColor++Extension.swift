//
//  UIColor++Extension.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 8/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIColor {
   func toImage() -> UIImage {
       let bounds: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
       let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(bounds: bounds)
       return renderer.image { rendererContext in
           rendererContext.cgContext.setFillColor(self.cgColor)
           rendererContext.cgContext.fill(bounds)
       }
   }
}


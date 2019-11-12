//
//  BehaviorRelay++Extension.swift
//  TextGameAdventures
//
//  Created by Taylah Lucas on 8/11/19.
//  Copyright © 2019 Archa. All rights reserved.
//

import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func replaceElementAtIndex(_ element: Element.Element, at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        newValue.insert(element, at: index)
        accept(newValue)
    }
    
    func removeElementAtIndex(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
}

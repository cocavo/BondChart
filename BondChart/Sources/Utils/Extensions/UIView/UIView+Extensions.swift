//
//  UIView+Extensions.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T>(_ nibName: String? = nil) -> T? {
        let nib = UINib(nibName: nibName ?? String(describing: T.self), bundle: nil)
        let objs = nib.instantiate(withOwner: nil, options: nil)
        return objs.first as? T
    }

    func fillParent() {
        guard let parent = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    }
}

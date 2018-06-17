//
//  BondRateDisplayMode.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

enum BondRateDisplayMode: String {
    case price, yield
}

extension BondRateDisplayMode: CustomStringConvertible {
    var description: String {
        return rawValue.uppercased()
    }
}

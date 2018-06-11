//
//  BondRate.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

typealias Price = Double
typealias Yield = Double

struct BondRate {
    let date: Date
    let price: Price
    let yield: Yield
}

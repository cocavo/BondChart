//
//  BondRateAPI.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

typealias ISIN = String

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol BondRateAPI {
    typealias Completion = (Result<[BondRate]>) -> Void

    func getBondRates(interval: DateInterval, completion: @escaping Completion)
    init(isin: ISIN)
}

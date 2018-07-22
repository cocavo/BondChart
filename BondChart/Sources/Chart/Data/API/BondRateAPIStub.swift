//
//  BondRateAPIStub.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

final class BondRateAPIStub: BondRateAPI {
    private let isin: ISIN
    private let workingQueue: DispatchQueue

    init(isin: ISIN) {
        self.isin = isin
        self.workingQueue = DispatchQueue(label: "com.bond_chart.api")
    }

    func getBondRates(interval: DateInterval, completion: @escaping BondRateAPI.Completion) {
        workingQueue.async {
            let rates = stride(
                from: interval.start.timeIntervalSince1970,
                to: interval.end.timeIntervalSince1970 + 1,
                by: .day
            )
                .map { BondRate.stub(date: Date(timeIntervalSince1970: $0)) }

            DispatchQueue.main.async {
                completion(.success(rates))
            }
        }
    }
}

extension BondRate {
    static func stub(date: Date) -> BondRate {
        return BondRate(
            date: date,
            price: Price(arc4random_uniform(100)),
            yield: Yield(arc4random_uniform(100))
        )
    }
}

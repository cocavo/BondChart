//
//  PriceDataEntryBuilder.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

final class PriceDataEntryBuilder: ChartDataEntryBuilding {
    func entries(for rates: [BondRate]) -> [ChartView.DataEntry] {
        return rates.map {
            ChartView.DataEntry(
                x: $0.date.timeIntervalSince1970,
                y: $0.price
            )
        }
    }
}

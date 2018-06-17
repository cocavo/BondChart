//
//  ChartDataEntryBuilderFactory.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

final class ChartDataEntryBuilderFactory {
    func builder(for displayMode: BondRateDisplayMode) -> ChartDataEntryBuilding {
        switch displayMode {
        case .price:
            return PriceDataEntryBuilder()
        case .yield:
            return YieldDataEntryBuilder()
        }
    }
}

//
//  File.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

protocol ChartDataEntryBuilding {
    func entries(for rates: [BondRate]) -> [ChartView.DataEntry]
}

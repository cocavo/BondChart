//
//  DateValueFormatter.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 12/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation
import Charts

final class DateValueFormatter: IAxisValueFormatter {
    private let dateFormatter: DateFormatter

    init() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM"
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}

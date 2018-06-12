//
//  TimeIntervalFormatter.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 12/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

protocol TimeIntervalFormatting {
    func string(for interval: TimeInterval) -> String
}

final class OneLetterFormatTimeIntervalFormatter: TimeIntervalFormatting {
    func string(for interval: TimeInterval) -> String {
        switch interval {
        case 0..<TimeInterval.day:
            return "1D"
        case TimeInterval.week..<TimeInterval.month:
            return "\(Int(interval / .week))W"
        case TimeInterval.month..<TimeInterval.year:
            return "\(Int(interval / .month))M"
        default:
            return "\(Int(interval / .year))Y"
        }
    }
}

extension TimeInterval {
    static let day: TimeInterval = 24 * 3600
    static let week: TimeInterval = 7 * day
    static let month: TimeInterval = 31 * day
    static let year: TimeInterval = 365 * day
}

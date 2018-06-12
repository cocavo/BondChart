//
//  ChartView.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import UIKit

final class ChartView: UIView {
    @IBOutlet private weak var tabbar: ChartTabBar!

    var timeIntervalFormatter: TimeIntervalFormatting!

    var dateIntervals: [DateInterval] = [] {
        didSet {
            tabbar.tabs = dateIntervals.map { timeIntervalFormatter.string(for: $0.duration) }
        }
    }
}

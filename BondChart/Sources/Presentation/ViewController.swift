//
//  ViewController.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private weak var chart: ChartView!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
    }

    private func setupChart() {
        let chart: ChartView = ChartView.loadFromNib()!
        chart.timeIntervalFormatter = OneLetterFormatTimeIntervalFormatter()
        chart.API = BondRateAPIStub(isin: 123456789012)
        view.addSubview(chart)
        chart.fillParent()
        chart.dateIntervals = [
            .week(),
            .month(),
            .month(3),
            .month(6),
            .year(),
            .year(2)
        ]
        self.chart = chart
    }
}

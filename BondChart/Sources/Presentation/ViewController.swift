//
//  ViewController.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
    }

    private func setupChart() {
        let chart: ChartView = ChartView.loadFromNib()!
        let dataSource = ChartDataSource(
            API: BondRateAPIStub(isin: "123456789012"),
            dataEntryBuilderFactory: ChartDataEntryBuilderFactory()
        )
        let vm = ChartViewModel(
            displayModes: [.price, .yield],
            dateIntervals: [
                .week(),
                .month(),
                .month(3),
                .month(6),
                .year(),
                .year(2)
            ],
            timeIntervalFormatter: OneLetterFormatTimeIntervalFormatter(),
            dataSource: dataSource
        )
        chart.viewModel = vm
        view.addSubview(chart)
        chart.fillParent()
    }
}

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
        view.addSubview(chart)
        chart.fillParent()
        chart.tabbar.tabs = [
            "1W",
            "1M",
            "3M",
            "6M",
            "1Y",
            "2Y"
        ]
        self.chart = chart
    }
}

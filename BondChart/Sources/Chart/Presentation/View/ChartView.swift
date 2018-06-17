//
//  ChartView.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import UIKit
import Charts

final class ChartView: UIView {
    struct DataEntry {
        let x: Double
        let y: Double
    }

    @IBOutlet private weak var tabbar: ChartTabBar!
    @IBOutlet private weak var lineChartView: LineChartView!
    
    var timeIntervalFormatter: TimeIntervalFormatting!
    var dataSource: ChartDataSource!

    var dateIntervals: [DateInterval] = [] {
        didSet {
            tabbar.tabs = dateIntervals.map { timeIntervalFormatter.string(for: $0.duration) }
            if !dateIntervals.isEmpty {
                fetchData(dateInterval: dateIntervals[0])
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTabbar()
        setupChart()
    }
}

private extension ChartView {
    func setupTabbar() {
        tabbar.onSelectTab = { [weak self] (tab) in
            guard let this = self else { return }
            this.fetchData(dateInterval: this.dateIntervals[tab])
        }
    }

    func setupChart() {
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.enabled = false

        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottomInside
        xAxis.labelFont = .chartLabelFont
        xAxis.labelTextColor = .black
        xAxis.valueFormatter = DateValueFormatter()

        let leftAxis = lineChartView.leftAxis
        leftAxis.labelPosition = .insideChart
        leftAxis.labelFont = .chartLabelFont
        leftAxis.labelTextColor = .black
        leftAxis.drawGridLinesEnabled = true
        leftAxis.drawLimitLinesBehindDataEnabled = true
    }

    func fetchData(dateInterval: DateInterval) {
        let config = ChartConfig(
            displayMode: .price,
            dateInterval: dateInterval
        )
        dataSource.fetchData(for: config) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case let .success(entries):
                this.render(entries: entries)
            case let .failure(error):
                print("Could not fetch bond rates \(error)")
            }
        }
    }

    func render(entries: [DataEntry]) {
        let dataSet = LineChartDataSet.bondDataSet(entries: entries)
        lineChartView.data = LineChartData(dataSet: dataSet)
    }
}

extension ChartView.DataEntry {
    var chartDataEntry: ChartDataEntry {
        return ChartDataEntry(x: x, y: y)
    }
}

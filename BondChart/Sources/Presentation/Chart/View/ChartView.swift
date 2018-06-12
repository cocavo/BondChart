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
    @IBOutlet private weak var tabbar: ChartTabBar!
    @IBOutlet private weak var lineChartView: LineChartView!
    
    var timeIntervalFormatter: TimeIntervalFormatting!
    var API: BondRateAPI!

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
        API.getBondRates(interval: dateInterval) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case let .success(rates):
                this.render(rates: rates)
            case let .failure(error):
                print("Could not fetch bond rates \(error)")
            }
        }
    }

    func render(rates: [BondRate]) {
        let entries = rates.map { ChartDataEntry.price($0) }
        let dataSet = LineChartDataSet(values: entries, label: nil)
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 3
        dataSet.setColor(UIColor(rgb: 0xEF798D))
        dataSet.valueFont = .chartLabelFont
        dataSet.valueTextColor = .black
        lineChartView.data = LineChartData(dataSet: dataSet)
    }
}

private extension ChartDataEntry {
    class func price(_ rate: BondRate) -> ChartDataEntry {
        return ChartDataEntry(
            x: rate.date.timeIntervalSince1970,
            y: rate.price
        )
    }
}

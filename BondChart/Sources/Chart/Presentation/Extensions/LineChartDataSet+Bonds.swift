//
//  LineChartDataSet+Bonds.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Charts

extension LineChartDataSet {
    static func bondDataSet(entries: [ChartView.DataEntry]) -> LineChartDataSet {
        let dataSet = LineChartDataSet(values: entries.map {$0.chartDataEntry}, label: nil)
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 3
        dataSet.setColor(UIColor(rgb: 0xEF798D))
        dataSet.valueFont = .chartLabelFont
        dataSet.valueTextColor = .black
        return dataSet
    }
}

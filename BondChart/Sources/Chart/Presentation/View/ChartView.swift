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
    
    var viewModel: ChartViewModel? {
        didSet {
            if let vm = viewModel {
                vm.chart = self
                tabbar.tabs = vm.tabs
                if !tabbar.tabs.isEmpty {
                    onSelectTab?(0)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupChart()
    }

    private func setupChart() {
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
}

extension ChartView: ChartDisplaying {
    func showSpinner() {
        print(#function)
    }

    func hideSpinner() {
        print(#function)
    }

    func render(error: Error) {
        print(#function)
    }

    func render(entries: [DataEntry]) {
        let dataSet = LineChartDataSet.bondDataSet(entries: entries)
        lineChartView.data = LineChartData(dataSet: dataSet)
    }

    var onChangeDisplayMode: ((String) -> Void)? {
        get {
            return nil
        }
        set {

        }
    }

    var onSelectTab: ((Int) -> Void)? {
        get {
            return tabbar.onSelectTab
        }
        set {
            tabbar.onSelectTab = newValue
        }
    }
}

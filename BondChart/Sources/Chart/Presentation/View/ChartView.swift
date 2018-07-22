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
    @IBOutlet private weak var displayModeButton: UIButton!

    var viewModel: ChartViewModel? {
        didSet {
            if let vm = viewModel {
                vm.chart = self
                tabbar.tabs = vm.tabs
            }
        }
    }

    var onChangeDisplayMode: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupChart()
        setupDisplayModeButton()
    }

    // MARK: Actions
    
    @IBAction private func changeDisplayMode(_ sender: Any) {
        onChangeDisplayMode?()
    }
}

private extension ChartView {
    func setupChart() {
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.enabled = false
        setup(chartDateAxis: lineChartView.xAxis)
        setup(chartValueAxis: lineChartView.leftAxis)
    }

    func setup(chartDateAxis axis: XAxis) {
        axis.labelPosition = .bottomInside
        axis.labelFont = .chartLabelFont
        axis.labelTextColor = .black
        axis.valueFormatter = DateValueFormatter()
    }

    func setup(chartValueAxis axis: YAxis) {
        axis.labelPosition = .insideChart
        axis.labelFont = .chartLabelFont
        axis.labelTextColor = .black
        axis.drawGridLinesEnabled = true
        axis.drawLimitLinesBehindDataEnabled = true
    }
}

private extension ChartView {
    func setupDisplayModeButton() {
        displayModeButton.semanticContentAttribute = .forceRightToLeft
        displayModeButton.titleLabel?.font = .chartLabelFont
        setupDisplayModeButtonShadow()
        setupDisplayModeButtonInsets()
    }

    func setupDisplayModeButtonShadow() {
        let layer = displayModeButton!.layer
        layer.cornerRadius = displayModeButton.bounds.height * 0.5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 8)
    }

    func setupDisplayModeButtonInsets() {
        displayModeButton.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: -20
        )
        displayModeButton.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 0,
            right: 20
        )
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

    func render(entries: [DataEntry], displayMode: BondRateDisplayMode) {
        let dataSet = LineChartDataSet.bondDataSet(entries: entries)
        lineChartView.data = LineChartData(dataSet: dataSet)
        displayModeButton.setTitle(
            displayMode.description,
            for: .normal
        )
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

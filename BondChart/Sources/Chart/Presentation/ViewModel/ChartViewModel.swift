//
//  ChartViewModel.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

final class ChartViewModel {
    private let displayModes: [BondRateDisplayMode]
    private let dateIntervals: [DateInterval]
    private let timeIntervalFormatter: TimeIntervalFormatting
    private let dataSource: ChartDataSource

    lazy var viewDisplayModes = displayModes.map { $0.description }
    lazy var tabs = dateIntervals.map { timeIntervalFormatter.string(for: $0.duration) }

    weak var chart: ChartDisplaying? {
        didSet {
            if let chart = chart {
                setup(chart: chart)
            }
        }
    }

    var onChangeDisplayMode: (() -> Void)?

    var currentDisplayMode: BondRateDisplayMode {
        didSet {
            if currentDisplayMode != oldValue {
                fetchData()
            }
        }
    }

    var currentDateInterval: DateInterval {
        didSet {
            if currentDateInterval != oldValue {
                fetchData()
            }
        }
    }

    init(displayModes: [BondRateDisplayMode],
         dateIntervals: [DateInterval],
         timeIntervalFormatter: TimeIntervalFormatting,
         dataSource: ChartDataSource)
    {
        precondition(!displayModes.isEmpty, "Chart display modes array must be not empty")
        precondition(!dateIntervals.isEmpty, "Chart date intervals array must be not empty")
        self.displayModes = displayModes
        self.dateIntervals = dateIntervals
        self.timeIntervalFormatter = timeIntervalFormatter
        self.dataSource = dataSource
        currentDisplayMode = displayModes.first!
        currentDateInterval = dateIntervals.first!
    }

    func fetchData() {
        chart?.showSpinner()
        dataSource.fetchData(for: currentChartConfig) { [weak self] (result) in
            guard let this = self else { return }

            this.chart?.hideSpinner()

            switch result {
            case let .success(entries):
                this.chart?.render(
                    entries: entries,
                    displayMode: this.currentDisplayMode
                )
            case let .failure(error):
                this.chart?.render(error: error)
            }
        }
    }
}

private extension ChartViewModel {
    func setup(chart: ChartDisplaying) {
        chart.onSelectTab = { [weak self] (tab) in
            guard let this = self else { return }
            this.currentDateInterval = this.dateIntervals[tab]
        }
        chart.onChangeDisplayMode = { [weak self] in
            guard let this = self else { return }
            this.onChangeDisplayMode?()
        }
    }

    var currentChartConfig: ChartConfig {
        return ChartConfig(
            displayMode: currentDisplayMode,
            dateInterval: currentDateInterval
        )
    }
}

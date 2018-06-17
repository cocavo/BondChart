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

    init(displayModes: [BondRateDisplayMode],
         dateIntervals: [DateInterval],
         timeIntervalFormatter: TimeIntervalFormatting,
         dataSource: ChartDataSource)
    {
        self.displayModes = displayModes
        self.dateIntervals = dateIntervals
        self.timeIntervalFormatter = timeIntervalFormatter
        self.dataSource = dataSource
    }
}

private extension ChartViewModel {
    func setup(chart: ChartDisplaying) {
        chart.onSelectTab = { [weak self] (tab) in
            guard let this = self else { return }
            this.fetchData(dateInterval: this.dateIntervals[tab])
        }
    }

    func fetchData(dateInterval: DateInterval) {
        let config = ChartConfig(displayMode: .price, dateInterval: dateInterval)
        chart?.showSpinner()
        dataSource.fetchData(for: config) { [weak self] (result) in
            guard let this = self else { return }

            this.chart?.hideSpinner()

            switch result {
            case let .success(entries):
                this.chart?.render(entries: entries)
            case let .failure(error):
                this.chart?.render(error: error)
            }
        }
    }
}

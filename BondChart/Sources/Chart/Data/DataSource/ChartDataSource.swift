//
//  ChartDataSource.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

enum BondRateDisplayMode {
    case price, yield
}

typealias ChartConfig = (displayMode: BondRateDisplayMode, dateInterval: DateInterval)

final class ChartDataSource {
    typealias Completion = (Result<[ChartView.DataEntry]>) -> Void

    private let API: BondRateAPI
    private let dataEntryBuilderFactory: ChartDataEntryBuilderFactory
    private let workingQueue: DispatchQueue

    init(API: BondRateAPI,
         dataEntryBuilderFactory: ChartDataEntryBuilderFactory)
    {
        self.API = API
        self.dataEntryBuilderFactory = dataEntryBuilderFactory
        self.workingQueue = DispatchQueue(label: "com.bond_chart.chart_data_source")
    }
}

extension ChartDataSource {
    func fetchData(for config: ChartConfig,
                   completion: @escaping Completion)
    {
        API.getBondRates(interval: config.dateInterval) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case let .success(rates):
                this.buildEntries(
                    rates: rates,
                    displayMode: config.displayMode,
                    completion: completion
                )
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func buildEntries(rates: [BondRate],
                              displayMode: BondRateDisplayMode,
                              completion: @escaping Completion) {
        workingQueue.async {
            let builder = self.dataEntryBuilderFactory.builder(for: displayMode)
            let entries = builder.entries(for: rates)
            DispatchQueue.main.async {
                completion(.success(entries))
            }
        }
    }
}

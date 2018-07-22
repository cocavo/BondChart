//
//  ViewController.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import UIKit

final class ChartViewController: UIViewController {
    private var chartViewModel: ChartViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChartViewModel()
        setupChart()
    }

    private func setupChart() {
        let chart: ChartView = ChartView.loadFromNib()!
        chart.viewModel = chartViewModel
        chart.fill(container: view)
        chartViewModel.fetchData()
    }

    private func setupChartViewModel() {
        let dataSource = ChartDataSource(
            API: BondRateAPIStub(isin: "123456789012"),
            dataEntryBuilderFactory: ChartDataEntryBuilderFactory()
        )
        let displayModes: [BondRateDisplayMode] = [.price, .yield]
        chartViewModel = ChartViewModel(
            displayModes: displayModes,
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
        chartViewModel.onChangeDisplayMode = { [unowned self] in
            self.showActionSheet(for: displayModes)
        }
    }
}

private extension ChartViewController {
    func showActionSheet(for displayModes: [BondRateDisplayMode]) {
        let sheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        displayModes.forEach {
            sheet.addAction(action(for: $0))
        }
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        sheet.addAction(cancel)
        present(
            sheet,
            animated: true
        )
    }

    func action(for displayMode: BondRateDisplayMode) -> UIAlertAction {
        return UIAlertAction(
            title: displayMode.description,
            style: .default,
            handler: { [unowned self] (_) in
                self.chartViewModel.currentDisplayMode = displayMode
        })
    }
}

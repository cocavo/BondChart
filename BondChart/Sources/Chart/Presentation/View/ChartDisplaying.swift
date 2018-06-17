//
//  ChartDisplaying.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 17/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation

struct DataEntry {
    let x: Double
    let y: Double
}

protocol ChartDisplaying: class {
    func showSpinner()
    func hideSpinner()
    func render(entries: [DataEntry])
    func render(error: Error)
    var onChangeDisplayMode: ((String) -> Void)? { get set }
    var onSelectTab: ((Int) -> Void)? { get set }
}

//
//  DateInterval+Extensions.swift
//  BondChart
//
//  Created by Dmitry Tuhtamanov on 11/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import Foundation
import AFDateHelper

extension DateInterval {
    static func week(_ count: Int) -> DateInterval {
        return interval(component: .week, offset: -count)
    }

    static func month(_ count: Int) -> DateInterval {
        return interval(component: .month, offset: -count)
    }

    static func year(_ count: Int) -> DateInterval {
        return interval(component: .year, offset: -count)
    }
}

private extension DateInterval {
    static func interval(component: DateComponentType, offset: Int) -> DateInterval {
        let now = Date()
        return DateInterval(
            start: now.adjust(component, offset: offset),
            end: now
        )
    }
}

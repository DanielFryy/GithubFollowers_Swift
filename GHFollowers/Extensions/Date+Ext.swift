//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/3/24.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}

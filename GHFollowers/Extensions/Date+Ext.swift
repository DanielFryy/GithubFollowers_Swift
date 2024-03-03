//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/3/24.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        return dateFormatter.string(from: self)
    }
}

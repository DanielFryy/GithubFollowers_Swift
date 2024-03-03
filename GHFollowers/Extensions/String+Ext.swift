//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/3/24.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)
    }

    func convertToDisplayFormat() -> String {
        guard let date = convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}

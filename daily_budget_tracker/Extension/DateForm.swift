//
//  DateForm.swift
//  daily_budget_tracker
//
//  Created by Snezhana Valchuk on 5/1/23.
//

import Foundation

extension DateFormatter{
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}

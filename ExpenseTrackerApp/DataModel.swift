//
//  DataModel.swift
//  ExpenseTrackerApp
//
//  Created by Hieu Dang on 7/14/24.
//

import Foundation

struct Expense: Codable, Identifiable {
    var id: String?
    var userId: String?
    var name: String
    var amount: Double
    var description: String?
    var createdAt: String?
    var updatedAt: String?
    var createdDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: createdAt!)
    }
}

struct Report: Codable, Identifiable {
    var id: String?
    var userId: String?
    var budget: Double
    var month_spent: Double
    var last_month_spent: Double
    var average_day_spent: Double
    var average_month_spent: Double
    var YTD: Double
    var createdAt: String?
    
}

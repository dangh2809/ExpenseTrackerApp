//
//  DataModel.swift
//  ExpenseTrackerApp
//
//  Created by Hieu Dang on 7/14/24.
//

import Foundation

struct Expense: Codable,Hashable {
    var _id: String?
    var userId: String?
    var name: String
    var amount: Double
    var description: String?
    var createdAt: String?
    var updatedAt: String?
    var createdDate: String? {
        let inputdateFormatter = DateFormatter()
        inputdateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        inputdateFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputdateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let inputdate : Date? = inputdateFormatter.date(from: createdAt!)
        let outputdateFormatter = DateFormatter()
        outputdateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        outputdateFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputdateFormatter.timeZone = TimeZone.current
        
        return outputdateFormatter.string(from: inputdate!)
    }
}

struct Report: Codable, Hashable,Identifiable {
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

struct ExpenseSearchResult: Codable {
    var entries_per_page: Int
    var expenses: [Expense]
    var filters: Dictionary<String, String>
    var page: Int
    var total_results: Int
}
struct EditExpenseResult: Codable {
    var expense_id: String
    var new_name: String
    var new_amount: Double
    var new_description: String
    var updatedAt: String
}

struct DeleteExpenseResult: Codable {
    var result: String
}


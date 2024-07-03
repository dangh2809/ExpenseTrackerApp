import SwiftUI
import Combine

class ExpenseData: ObservableObject {
    @Published var expenses: [Expense] = []

    var budget: Double = 500.0
    var totalSpent: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    var progress: Double {
        totalSpent / budget
    }
    var todaysSpent: Double {
        expenses.filter { Calendar.current.isDateInToday($0.date) }.reduce(0) { $0 + $1.amount }
    }
    var weeksSpent: Double {
        expenses.filter { Calendar.current.isDateInThisWeek($0.date) }.reduce(0) { $0 + $1.amount }
    }
    var averageDaySpent: Double {
        totalSpent / Double(expenses.count)
    }
    var averageMonthSpent: Double {
        // Example calculation, assuming expenses array has dates from the same year.
        totalSpent / Double(Calendar.current.component(.month, from: Date()))
    }
    var lastMonthSpent: Double {
        expenses.filter { Calendar.current.isDate($0.date, equalTo: Date().addingTimeInterval(-30*24*60*60), toGranularity: .month) }.reduce(0) { $0 + $1.amount }
    }
    var ytdSpent: Double {
        expenses.filter { Calendar.current.component(.year, from: $0.date) == Calendar.current.component(.year, from: Date()) }.reduce(0) { $0 + $1.amount }
    }
}

struct Expense: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var date: Date
    var description: String
}

extension Calendar {
    func isDateInThisWeek(_ date: Date) -> Bool {
        return self.isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
    }
}

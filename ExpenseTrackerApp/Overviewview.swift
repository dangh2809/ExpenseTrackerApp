import SwiftUI

struct OverviewView: View {
    @EnvironmentObject var expenseData: ExpenseData

    var body: some View {
        VStack {
            Text("Overview")
                .font(.title)
                .padding()
            CircularProgressBar(progress: expenseData.progress, budget: expenseData.budget)
            Text("You have \(String(format: "$%.2f", expenseData.budget - expenseData.totalSpent)) available")
                .padding()
            ExpenseSummaryView()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct CircularProgressBar: View {
    var progress: Double
    var budget: Double

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                .frame(width: 150, height: 150)
            Circle()
                .trim(from: 0.0, to: progress / budget)
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(-90))
            Text(String(format: "$%.2f", progress))
                .font(.title)
        }
    }
}

struct ExpenseSummaryView: View {
    @EnvironmentObject var expenseData: ExpenseData

    var body: some View {
        VStack {
            Text("Today's spent: \(String(format: "$%.2f", expenseData.todaysSpent))")
            Text("Week's spent: \(String(format: "$%.2f", expenseData.weeksSpent))")
            Text("Average day spent: \(String(format: "$%.2f", expenseData.averageDaySpent))")
            Text("Average month spent: \(String(format: "$%.2f", expenseData.averageMonthSpent))")
            Text("Last month spent: \(String(format: "$%.2f", expenseData.lastMonthSpent))")
            Text("YTD: \(String(format: "$%.2f", expenseData.ytdSpent))")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

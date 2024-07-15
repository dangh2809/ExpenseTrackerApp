import SwiftUI

struct OverviewView: View {
    @State private var reportData : Report?
//    @State private var month: String = "4"
//    @State private var year: String = "2023"
    @State private var isLoading = true
    var body: some View {
        VStack {
            if isLoading {
                Text("Loading...")
            } else if let reportData = reportData {
                Text("Overview")
                    .font(.title)
                    .padding()
                CircularProgressBar(progress: reportData.month_spent , budget: reportData.budget )
                Text("You have \(String(format: "$%.2f", reportData.budget - reportData.month_spent )) available")
                    .padding()
                ExpenseSummaryView(report_data: reportData)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear(perform: {
            fetchReport(month: nil, year: nil)
        })
    }
    func fetchReport(month: String?, year: String?) {
        APIService.shared.getMonthReport(month: month, year:year){ result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let report):
                    self.reportData = report
                case .failure(let error):
                    print(error)
                }
            }
        }
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
    var report_data: Report

    var body: some View {
        VStack {
            Text("This month's spent: \(String(format: "$%.2f", report_data.month_spent))")
            Text("Last month's spent: \(String(format: "$%.2f", report_data.last_month_spent))")
            Text("Average day spent: \(String(format: "$%.2f", report_data.average_day_spent))")
            Text("Average month spent: \(String(format: "$%.2f", report_data.average_month_spent))")
            Text("YTD: \(String(format: "$%.2f", report_data.YTD))")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

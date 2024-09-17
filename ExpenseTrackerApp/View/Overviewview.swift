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
//        let report : [String: Any] = [
//            "YTD": 10.57,
//            "average_day_spent": 10.57,
//            "average_month_spent": 10.57,
//            "budget": 345.43,
//            "createdAt": "Sun, 14 Jul 2024 19:18:19 GMT",
//            "id": "66945cbb717cab06d01d92de",
//            "last_month_spent": 0,
//            "month_spent": 10.57,
//            "userId": "0"
//        ]
        APIService.shared.getMonthReport(month: month, year:year){ result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let report):
                    isLoading = false
                    print("success")
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
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
#Preview {
    OverviewView()
}

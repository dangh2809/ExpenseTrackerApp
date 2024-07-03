import SwiftUI

@main
struct ExpenseTrackerAppApp: App {
    @StateObject var expenseData = ExpenseData()

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    OverviewView()
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

                NavigationView {
                    ExpenseListView()
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Expense")
                }

                NavigationView {
                    AddExpenseView()
                }
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
            }
            .environmentObject(expenseData)
        }
    }
}

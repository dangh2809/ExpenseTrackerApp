import SwiftUI

struct ExpenseListView: View {
    @State private var expenses: [Expense] = []
    @State private var isLoading = true
    var body: some View {
        
        List() {
            if isLoading {
                Text("Loading...")
            } else  {
                ForEach(expenses, id: \.self) { expense in
                    ExpenseRow(expense: expense)
                }
            }
            
        }
        .navigationBarTitle("Expense")
//        .navigationBarItems(trailing: NavigationLink(destination: AddExpenseView()) {
//            Image(systemName: "plus")
//        })
        .onAppear(perform: fetchExpense)
    }
    func fetchExpense() {
        APIService.shared.get_expenses { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetch_result):
                    self.expenses = fetch_result.expenses
                    print("Fetched expenses:")
//                    for expense in self.expenses {
//                        print("Name: \(expense.name), Amount: \(expense.amount), Date: \(expense.createdAt)")
//                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct ExpenseRow: View {
    var expense: Expense

    var body: some View {
        HStack {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.createdDate!)
                    .font(.subheadline)
            }
            Spacer()
            Text(String(format: "$%.2f", expense.amount))
                .font(.headline)
        }
        .padding()
    }
}

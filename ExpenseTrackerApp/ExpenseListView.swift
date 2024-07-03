import SwiftUI

struct ExpenseListView: View {
    @EnvironmentObject var expenseData: ExpenseData

    var body: some View {
        List {
            ForEach(expenseData.expenses) { expense in
                ExpenseRow(expense: expense)
            }
            .onDelete(perform: deleteItems)
        }
        .navigationBarTitle("Expense")
        .navigationBarItems(trailing: NavigationLink(destination: AddExpenseView()) {
            Image(systemName: "plus")
        })
    }

    func deleteItems(at offsets: IndexSet) {
        expenseData.expenses.remove(atOffsets: offsets)
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
                Text(expense.date, style: .date)
                    .font(.subheadline)
            }
            Spacer()
            Text(String(format: "$%.2f", expense.amount))
                .font(.headline)
        }
        .padding()
    }
}

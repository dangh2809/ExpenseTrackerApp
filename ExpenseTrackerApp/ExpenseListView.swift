//import SwiftUI
//
//struct ExpenseListView: View {
//    @State private var expenses: [Expense] = []
//
//    var body: some View {
//        List {
//            ForEach(expenses) { expense in
//                ExpenseRow(expense: expense)
//            }
//        }
//        .navigationBarTitle("Expense")
//        .navigationBarItems(trailing: NavigationLink(destination: AddExpenseView()) {
//            Image(systemName: "plus")
//        })
//    }
// 
//}
//
//struct ExpenseRow: View {
//    var expense: Expense
//
//    var body: some View {
//        HStack {
//            Image(systemName: "photo")
//                .resizable()
//                .frame(width: 40, height: 40)
//            VStack(alignment: .leading) {
//                Text(expense.name)
//                    .font(.headline)
//                Text(expense.createdDate!, style: .date)
//                    .font(.subheadline)
//            }
//            Spacer()
//            Text(String(format: "$%.2f", expense.amount))
//                .font(.headline)
//        }
//        .padding()
//    }
//}

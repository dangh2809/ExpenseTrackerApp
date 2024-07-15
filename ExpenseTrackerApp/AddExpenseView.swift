//import SwiftUI
//
//struct AddExpenseView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var expenseData: ExpenseData
//    @State private var amount: String = ""
//    @State private var name: String = ""
//    @State private var description: String = ""
//
//    var body: some View {
//        VStack {
//            TextField("Amount", text: $amount)
//                .font(.largeTitle)
//                .keyboardType(.decimalPad)
//                .padding()
//
//            TextField("What for?", text: $name)
//                .padding()
//
//            TextField("Description", text: $description)
//                .padding()
//
//            VStack {
//                TipView(amount: $amount, percentage: 0.15)
//                TipView(amount: $amount, percentage: 0.18)
//                TipView(amount: $amount, percentage: 0.20)
//            }
//            .padding()
//
//            Button(action: {
//                addExpense()
//            }) {
//                Text("Confirm")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//
//            Spacer()
//
//            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Text("Cancel")
//                    .foregroundColor(.red)
//            }
//        }
//        .navigationBarTitle("Add Expense")
//        .padding()
//    }
//
//    func addExpense() {
//        if let expenseAmount = Double(amount) {
//            let newExpense = Expense(name: name, amount: expenseAmount, description: description)
//            // call add expense API
//            
//            self.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
//
//struct TipView: View {
//    @Binding var amount: String
//    var percentage: Double
//
//    var body: some View {
//        Text(String(format: "Tip %.0f%%: $%.2f", percentage * 100, (Double(amount) ?? 0.0) * percentage))
//    }
//}

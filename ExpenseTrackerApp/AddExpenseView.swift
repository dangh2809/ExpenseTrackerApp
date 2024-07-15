import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var amount: String = ""
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedTipPercentage: Double? = nil // State variable for selected tip percentage
    
    
    var totalAmount: Double?{
            let expenseAmount = Double(amount) ?? 0
            if let tipPercentage = selectedTipPercentage {
                return expenseAmount + (expenseAmount * tipPercentage)
            }
            return expenseAmount
        }

    var body: some View {
        VStack {
            TextField("Amount", text: $amount)
                .font(.largeTitle)
                .keyboardType(.decimalPad)
                .padding()

            TextField("What for?", text: $name)
                .padding()

            TextField("Description", text: $description)
                .padding()

            VStack {
                TipButtonView(amount: $amount, percentage: 0.15, selectedTipPercentage: $selectedTipPercentage)
                TipButtonView(amount: $amount, percentage: 0.18, selectedTipPercentage: $selectedTipPercentage)
                TipButtonView(amount: $amount, percentage: 0.20, selectedTipPercentage: $selectedTipPercentage)
            }
            .padding()
            
            Text(String(format: "Total: $%.2f", totalAmount ?? 0))
                .font(.title2)
                .padding()
            
            Button(action: {
                addExpense()
            }) {
                Text("Confirm")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
        .navigationBarTitle("Add Expense")
        .padding()
    }

    func addExpense() {
        if let expenseAmount = totalAmount {
            let newExpense = Expense(name: name, amount: expenseAmount, description: description)
            // call add expense API
            APIService.shared.add_expense(new_expense: newExpense) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let added_expense):
                        print(added_expense)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
struct TipButtonView: View {
    @Binding var amount: String
    var percentage: Double
    @Binding var selectedTipPercentage: Double? // Binding for selected tip percentage

    var body: some View {
        Button(action: {
            selectedTipPercentage = percentage
        }) {
            HStack {
                Text(String(format: "Tip %.0f%%: $%.2f", percentage * 100, (Double(amount) ?? 0.0) * percentage))
                    .foregroundColor(selectedTipPercentage == percentage ? .white : .blue)
                Spacer()
            }
            .padding()
            .background(selectedTipPercentage == percentage ? Color.blue : Color.clear)
            .cornerRadius(10)
        }
    }
}
//struct TipView: View {
//    @Binding var amount: String
//    var percentage: Double
//
//    var body: some View {
//        Text(String(format: "Tip %.0f%%: $%.2f", percentage * 100, (Double(amount) ?? 0.0) * percentage))
//    }
//}

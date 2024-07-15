//
//  ExpenseDetailView.swift
//  ExpenseTrackerApp
//
//  Created by Hieu Dang on 7/15/24.
//

import SwiftUI

struct ExpenseDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var expense: Expense
    @State private var isEditing = false // State variable to track edit mode


    var body: some View {
        VStack(alignment: .leading) {
            TextField("Expense Name", text: $expense.name)
                .font(.largeTitle)
                .disabled(!isEditing)
                .padding(.bottom, 10)
            
            TextField("Amount", value: $expense.amount, formatter: NumFormatter.currency)
                .font(.title)
                .disabled(!isEditing)
                .padding(.bottom, 10)

            TextField("Description", text: bindingForOptionalString($expense.description))
                .font(.body)
                .disabled(!isEditing)
                .padding(.bottom, 10)
            
            
            Text(expense.createdDate!)
                .font(.body)
                .padding(.bottom, 10)
//            Text(DateFormatter.localizedString(from: expense.createdDate ?? Date(), dateStyle: .medium, timeStyle: .short))
//                .font(.body)
//                .padding(.bottom, 10)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Expense Details", displayMode: .inline)
        .navigationBarItems(trailing: HStack {
            if isEditing {
                Button(action: {
                    // Save changes
                    onSave()
                    isEditing = false
                }) {
                    Text("Save")
                }
            } else {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image(systemName: "pencil")
                }
            }
            Button(action: {
                onRemove()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "trash")
            }
        }).onAppear(perform: {
            print("expense: ")
            print(expense)
        })
        
    }
    // Helper function to create a non-optional binding
    private func bindingForOptionalString(_ optionalBinding: Binding<String?>) -> Binding<String> {
        return Binding<String>(
            get: { optionalBinding.wrappedValue ?? "" },
            set: { optionalBinding.wrappedValue = $0 }
        )
    }
    func onSave(){
        let input: [String:Any] = [
            "expense_id": expense._id!,
            "new_amount": expense.amount,
            "new_description": expense.description!,
            "new_name": expense.name
        ]
        APIService.shared.edit_expense(updated_expense: input) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let edit_result):
                    print(edit_result)
                case .failure(let error):
                    print(error)
                }
            }
        }
        return
    }
    
    func onRemove(){
        return
    }
}

struct NumFormatter {
    static let currency: Formatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}


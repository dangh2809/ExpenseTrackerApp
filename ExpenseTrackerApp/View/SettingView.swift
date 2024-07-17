//
//  SettingView.swift
//  ExpenseTrackerApp
//
//  Created by Hieu Dang on 7/15/24.
//

import SwiftUI

struct SettingView: View {
    @State private var budget: String = ""
    @State private var isLoading = true
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            if isLoading {
                Text("Loading...")
            } else {
                Text("Current Budget").font(.title3)
                HStack(alignment: .top) {
                    Text("$")
                        .font(.title)
                        .padding(.leading, 8)
                    TextField("Amount", text: $budget)
                        .keyboardType(.decimalPad)
                        .font(.title)
                        .background(isEditing ? Color.gray.opacity(0.1):Color.clear )
                        .disabled(!isEditing)
                    
                    Button(action: {
                        if isEditing {
                            setBudget(added_budget: Double(budget)!)
                        }
                        isEditing.toggle()
                    }) {
                        Image(systemName: isEditing ? "checkmark" : "pencil")
                            .padding()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Setting")
        .padding()
        .onAppear(perform: getBudget)
    }
    
    func getBudget() {
        
        APIService.shared.getMonthReport(month: nil, year: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let report):
                    
                    self.budget = String(format: "%.2f", report.budget)
                    isLoading = false
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func setBudget(added_budget: Double) {
        APIService.shared.set_budget(a_budget: added_budget) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let report):
                    print("success")
                    self.budget = String(format: "%.2f", report.new_budget)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
}

#Preview {
    SettingView()
}

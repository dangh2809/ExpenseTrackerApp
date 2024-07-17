import SwiftUI

struct ExpenseListView: View {
    @State private var expenses: [Expense] = []
    @State private var isLoading = true
    @State private var showSearchBar = false
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            VStack{
                if showSearchBar {
                    TextField("Search...", text: $searchText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                List {
                    if isLoading {
                        Text("Loading...")
                    } else  {
                        ForEach(expenses, id: \.self) { expense in
                            ExpenseRow(expense: expense)
                        }
                    }
                    
                }
                .navigationBarTitle("Expense")
                .navigationBarItems(trailing: HStack {
                    Button(action: {
                        showSearchBar.toggle()
                        if !showSearchBar {
                            searchText = ""
                        }
                    }) {
                        Image(systemName: showSearchBar ? "xmark" : "magnifyingglass")
                    }
                    NavigationLink(destination: AddExpenseView()) {
                        Image(systemName: "plus")
                    }
                })
                .onAppear(perform: fetchExpense)
            }
            
        }
        
    }
    func fetchExpense() {
        APIService.shared.get_expenses(search_text: searchText) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetch_result):
                    self.expenses = fetch_result.expenses
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
        NavigationLink(destination: ExpenseDetailView(expense: expense)){
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
}

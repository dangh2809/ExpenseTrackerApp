
# Expense Tracker App

This is an iOS Expense Tracker app built using Swift and SwiftUI. The app allows users to track their daily, weekly, and monthly expenses, manage their budget, and view summaries of their spending habits.

## Features

- **Overview Screen**: Displays a summary of the user's budget, total spending, and spending breakdown.
- **Expense List Screen**: Shows a list of all recorded expenses with the ability to add new expenses.
- **Add Expense Screen**: Allows users to input new expenses, including the amount, description, and optional tip calculations.

## Project Structure

- **ExpenseModel.swift**: Defines the `Expense` model and `ExpenseData` class for managing expenses and calculating various spending summaries.
- **AddExpenseView.swift**: Provides the user interface and functionality for adding new expenses.
- **ExpenseListView.swift**: Displays a list of all expenses and allows users to delete expenses.
- **OverviewView.swift**: Shows a summary of the user's budget and spending.
- **ExpenseTrackerApp.swift**: The main app file that sets up the tab navigation and integrates the different views.

## Getting Started

To run this app, follow these steps:

1. **Clone the repository**:
    ```sh
    git clone <repository-url>
    ```

2. **Open the project in Xcode**:
    Open the cloned repository in Xcode.

3. **Build and run the app**:
    Select your target device or simulator and click the "Run" button in Xcode.

## Screenshots

### Overview Screen
![Overview Screen](images/overview.png)

### Expense List Screen
![Expense List Screen](images/expense_list.png)

### Add Expense Screen
![Add Expense Screen](images/add_expense.png)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

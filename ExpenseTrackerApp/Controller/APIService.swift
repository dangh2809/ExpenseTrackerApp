//
//  APIService.swift
//  ExpenseTrackerApp
//
//  Created by Hieu Dang on 7/13/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    let baseURL = "http://127.0.0.1:5000/api"
    
    // Get Total Spent for the Month
    func getMonthReport(month: String?, year: String?, completion: @escaping (Result<Report, Error>) -> Void) {
        //guard let url = URL(string: "\(baseURL)/report") else { return }
        guard var urlComponents = URLComponents(string: "\(baseURL)/report") else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "year", value: year ?? String(Calendar.current.component(.year, from: Date()))),
            URLQueryItem(name: "month", value:  month ?? String(Calendar.current.component(.month, from: Date())))
        ]
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            print("data is here")
            
            do {
                let month_report = try JSONDecoder().decode(Report.self, from: data)
                completion(.success(month_report))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func get_expenses(search_text: String?,    completion: @escaping (Result<ExpenseSearchResult, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(baseURL)/expense/search") else { return }
        if search_text != "" {
            urlComponents.queryItems = [
                URLQueryItem(name: "text", value: search_text )
            ]
        }
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            print("data is here")
            
            do {
                let expenses = try JSONDecoder().decode(ExpenseSearchResult.self, from: data)
                completion(.success(expenses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func add_expense(new_expense: Expense, completion: @escaping (Result<Expense, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/expense") else { return }
        let input: [String:Any] = [
            "amount": new_expense.amount,
            "name": new_expense.name,
            "description": new_expense.description!
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: input)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            print("data is here")
            
            do {
                let added_expense = try JSONDecoder().decode(Expense.self, from: data)
                completion(.success(added_expense))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func edit_expense(updated_expense:[String:Any], completion: @escaping (Result<EditExpenseResult, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/expense") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONSerialization.data(withJSONObject: updated_expense)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            print("data is here")
            
            do {
                print("hell")
                let result = try JSONDecoder().decode(EditExpenseResult.self, from: data)
                print(result)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func remove_expense(expense_id: String, completion: @escaping (Result<DeleteExpenseResult, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/expense") else { return }
        let input: [String: Any]=[
            "expense_id": expense_id
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = try! JSONSerialization.data(withJSONObject: input)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                
                let result = try JSONDecoder().decode(DeleteExpenseResult.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func set_budget(a_budget: Double, completion: @escaping (Result<SetBudgetResult, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/budget") else { return }
        
        let input : [String: Any] = [
            "month": Int(Calendar.current.component(.month, from: Date())),
            "year": Int(Calendar.current.component(.year, from: Date())),
            "budget": a_budget
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONSerialization.data(withJSONObject: input)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                
                let result = try JSONDecoder().decode(SetBudgetResult.self, from: data)
                completion(.success(result))
            } catch {
                print("error in API")
                completion(.failure(error))
            }
        }.resume()
    }
}

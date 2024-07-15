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

  
    
}

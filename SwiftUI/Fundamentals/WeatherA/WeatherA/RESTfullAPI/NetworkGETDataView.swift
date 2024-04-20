//
//  NetworkGETDataView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 16.04.2024.
//

import Foundation
import SwiftUI

struct NetworkGETDataView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    EmployeesView()
                } label: {
                    HStack {
                        Text("Employees")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                }
                
                Spacer()
            }
            .navigationTitle("Fetching Async Await")
        }
    }
}

#Preview {
    NetworkGETDataView()
}

struct EmployeesView: View {
//    @StateObject var networkManager = NetworkManager.shared
    @StateObject var networkManager = AsyncAwaitView()
//    @State private var employees = [Employee]()
//    @State private var showProgress: Bool = false
//    @State private var showError: Bool = false
//    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            List(networkManager.employees, id: \.self) { employee in
                HStack {
                    Text(employee.employee_name)
                    Spacer()
                    Text(employee.employee_salary, format: .number)
                }
            }
            
            if networkManager.inProgress {
                ProgressView()
            }
//            ProgressView()
//                .progressViewStyle(.circular)
//                .opacity(showProgress ? 1 : 0)
        }
        .alert(isPresented: $networkManager.showError) {
            Alert(title: Text(networkManager.errorMessage))
        }
//        .onAppear {
//            showProgress = true
//            networkManager.fetchEmployees { result in
//                showProgress = false
//                switch result {
//                case .success(let decodedEmployees):
//                    print("success")
//                    
//                    employees = decodedEmployees
//                    
//                case .failure(let networkError):
//                    print("feilure: \(networkError)")
//                    errorMessage = warningMessage(error: networkError)
//                    showError = true
//                }
//            }
//        }
        .task {
            await networkManager.fetchAllEmployees()
        }
    }
    
//    private func fetchData() async {
//        do {
//            let (data, response) = try await URLSession.shared.data(from: Link.employees.url)
//            // check for response status here
//            if let httpResponse = response as? HTTPURLResponse {
//                print(httpResponse.statusCode)
//            }
//            
//            // decode that data
//            if let decodedResponse = try? JSONDecoder().decode(Query.self, from: data) {
//                print(decodedResponse.status)
//                employees = decodedResponse.data
//            }
//        } catch let connectionError {
//            print("Wrong data from API: \(connectionError)")
//        }
//    }
}

//________________________________________________________ Model
struct Employee: Decodable, Hashable {
    let id: Int
    let employee_name: String
    let employee_salary: Int
}

struct Query: Decodable {
    let status: String
    let data: [Employee]
}

extension Employee {
    static let example = Employee(id: 1, employee_name: "Tim Cook", employee_salary: 30000)
}

//________________________________________________________ Manager
enum Link {
    case employees
    
    var url: URL {
        switch self {
        case .employees:
            return URL(string: "https://dummy.restapiexample.com/api/v1/employees")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case tooManyRequests
    case decodingError
}

//final class NetworkManager: ObservableObject {
//    
//    init() {}
//    
//    static let shared = NetworkManager()
//    
//    func fetchEmployees(completion: @escaping (Result<[Employee], NetworkError>) -> Void) {
//        print("try to fetch")
//        
//        let fetchRequest = URLRequest(url: Link.employees.url)
//        
//        URLSession.shared.dataTask(with: fetchRequest) { (data, response, error) -> Void in
//            if error != nil {
//                print("Error in session is not nil")
//                completion(.failure(.noData))
//            } else {
//                // We've got data!
//                let httpResponse = response as? HTTPURLResponse
//                print("status code: \(String(describing: httpResponse?.statusCode ?? 0))")
//                
//                if httpResponse?.statusCode == 429 {
//                    completion(.failure(.tooManyRequests))
//                } else {
//                    guard let safeData = data else { return }
//                    
//                    do {
//                        let decodedQuery = try JSONDecoder().decode(Query.self, from: safeData)
//                        
//                        completion(.success(decodedQuery.data))
//                        
//                    } catch let decodeError {
//                        print("Decoding error: \(decodeError)")
//                        completion(.failure(.decodingError))
//                    }
//                }
//            }
//        }
//        .resume()
//    }
//}

//________________________________________________________ Helper
func warningMessage(error: NetworkError) -> String {
    switch error {
    case .noData:
        return "Data cannot be found at this URL"
    case .tooManyRequests:
        return "429: Too many requests"
    case .decodingError:
        return "Can't decode data"
    }
}


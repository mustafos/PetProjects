//
//  URLSessionView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 16.04.2024.
//

import Foundation
import SwiftUI

struct URLSessionView: View {
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
            .navigationTitle("Fetching Data")
        }
    }
}

#Preview {
    URLSessionView()
}

struct EmployeesView: View {
    
    @StateObject var networkManager = NetworkManager.shared
    
//    @State private var employees = [Employee]() Singleton
    
    var body: some View {
        ZStack {
            List(networkManager.employees, id: \.self) { employee in
                HStack {
                    Text(employee.employee_name)
                    Spacer()
                    Text(employee.employee_salary, format: .number)
                }
            }
        }
        onAppear {
            networkManager.fetchEmployees()
        }
    }
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

final class NetworkManager: ObservableObject {
    
    init() {}
    
    static let shared = NetworkManager()
    
    @Published var employees = [Employee]()
    
    func fetchEmployees() {
        print("try to fetch")
        
        let fetchRequest = URLRequest(url: Link.employees.url)
        
        URLSession.shared.dataTask(with: fetchRequest) { [weak self] (data, response, error) -> Void in
            if error != nil {
                print("Error in session is not nil")
            } else {
                // We've got data!
                let httpResponse = response as? HTTPURLResponse
                print("status code: \(String(describing: httpResponse?.statusCode))")
                
                guard let safeData = data else { return }
                
                if let decodedQuery = try? JSONDecoder().decode(Query.self, from: safeData) {
                    DispatchQueue.main.async {
                        self?.employees = decodedQuery.data
                    }
                }
            }
        }
        .resume()
    }
}

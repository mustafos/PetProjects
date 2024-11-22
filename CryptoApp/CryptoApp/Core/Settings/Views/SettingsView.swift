//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 23.11.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://google.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let githubURL = URL(string: "https://github.com/mustafos")!
    let coffeeURL = URL(string: "https://buymeacoffee.com/mustafos")!
    let linkedinURL = URL(string: "https://www.linkedin.com/in/mustafabekirov/")!
    let portfolioURL = URL(string: "https://mustafos.github.io")!
    
    var body: some View {
        NavigationView {
            List {
                aboutSection
                coinGeckoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var aboutSection: some View {
        Section(header: Text("About the App")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed to showcase my skills in using modern development technologies, including MVVM architecture, SwiftUI, Combine, CoreData, and RESTful APIs. Built with a focus on clean code and scalability, it integrates advanced state management and seamless data persistence.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }.padding(.vertical)
            
            Link("Follow me on GitHub 💻", destination: githubURL)
            Link("Buy me a coffee ☕️", destination: coffeeURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("CoinGecko is a leading cryptocurrency data aggregator providing real-time market data, charts, and analytics for thousands of cryptocurrencies. This app integrates CoinGecko's API to deliver accurate and up-to-date information, showcasing the capabilities of working with RESTful APIs and data-driven interfaces.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }.padding(.vertical)
            
            Link("Visit CoinGecko Website 🐸", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("developer")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Hi! I'm the developer of this app, passionate about building intuitive and robust software solutions. With expertise in Swift, SwiftUI, MVVM architecture, and RESTful APIs, I strive to create clean, scalable, and efficient applications that solve real-world problems.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }.padding(.vertical)
            
            Link("Connect with me on LinkedIn 🔗", destination: linkedinURL)
            Link("Check out my Portfolio 🌐", destination: portfolioURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service 📜", destination: defaultURL)
            Link("Privacy Policy 📜", destination: defaultURL)
            Link("Company Website 📜", destination: defaultURL)
            Link("Lern More 📜", destination: defaultURL)
        }
    }
}

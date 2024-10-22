//
//  CountryViewModel.swift
//  vpn_app
//
//  Created by Mustafa Bekirov on 04.09.2024.
//

import SwiftUI
import Combine
import Network

class CountryViewModel: ObservableObject {
    @AppStorage("userName") var userName: String = ""
    @Published var countries: [CountryModel] = []
    @Published var selectedCountry: CountryModel?
    @Published var searchText: String = ""
    @Published var elapsedTime: String = "00:00:00"
    @Published var isConnected: Bool = false
    @Published var isPresentAddName: Bool = false
    @Published var userIPAddress: String = ""
    
    private var startTime: Date?
    private var timer: AnyCancellable?
    
    init() {
        loadCountries()
        getIpAddress()
    }
    
    func loadCountries() {
        countries = [
            CountryModel(name: .usa, flagImageName: .usa, isFavorite: false, isLock: true),
            CountryModel(name: .germany, flagImageName: .germany, isFavorite: false, isLock: false),
            CountryModel(name: .australia, flagImageName: .australia, isFavorite: false, isLock: false),
            CountryModel(name: .azerbaijan, flagImageName: .azerbaijan, isFavorite: false, isLock: false),
            CountryModel(name: .belgium, flagImageName: .belgium, isFavorite: false, isLock: false),
            CountryModel(name: .brazil, flagImageName: .brazil, isFavorite: false, isLock: false),
            CountryModel(name: .denmark, flagImageName: .denmark, isFavorite: false, isLock: true),
            CountryModel(name: .france, flagImageName: .france, isFavorite: false, isLock: false),
            CountryModel(name: .netherlands, flagImageName: .netherlands, isFavorite: false, isLock: true),
            CountryModel(name: .uk, flagImageName: .uk, isFavorite: false, isLock: false),
            CountryModel(name: .spain, flagImageName: .spain, isFavorite: false, isLock: true),
            CountryModel(name: .italy, flagImageName: .italy, isFavorite: false, isLock: false),
            CountryModel(name: .hungary, flagImageName: .hungary, isFavorite: false, isLock: false),
            CountryModel(name: .norway, flagImageName: .norway, isFavorite: false, isLock: true),
            CountryModel(name: .portugal, flagImageName: .portugal, isFavorite: false, isLock: true),
            CountryModel(name: .russia, flagImageName: .russia, isFavorite: false, isLock: true),
            CountryModel(name: .chile, flagImageName: .chile, isFavorite: false, isLock: true),
            CountryModel(name: .ukraine, flagImageName: .ukraine, isFavorite: false, isLock: true),
            CountryModel(name: .uruguay, flagImageName: .uruguay, isFavorite: false, isLock: false)
        ]
        selectedCountry = countries.first
    }
    
    //Filter
    var filteredCountries: [CountryModel] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter {
                $0.name.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    //Add Favorite
    func toggleFavorite(for country: CountryModel) {
        if let index = countries.firstIndex(where: { $0.id == country.id }) {
            countries[index].isFavorite.toggle()
            selectedCountry = countries[index]
        }
    }
    
    // Method to toggle connection and manage timer
    func toggleConnection() {
        isConnected.toggle()
        if isConnected {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    // Timer Private Methods
    private func startTimer() {
        startTime = Date()
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                if let startTime = self?.startTime {
                    let currentTime = Date()
                    let elapsed = currentTime.timeIntervalSince(startTime)
                    self?.elapsedTime = self?.formatTime(elapsed) ?? "00:00:00"
                }
            }
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
        elapsedTime = "00:00:00"  // Reset the timer display
    }
    
    private func formatTime(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    // Get the device's IP address
    func getIpAddress() {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                let interface = ptr!.pointee
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) {
                    let name = String(cString: interface.ifa_name)
                    if name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                        break
                    }
                }
                ptr = interface.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        
        userIPAddress = address ?? ""
    }
}

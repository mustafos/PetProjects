//
//  ArrayStorage.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 21.11.2023.
//

import SwiftUI

//MARK: – First variant save Data by codable prot
struct Settings: Codable {
    let inNight: Bool
    let name: String
}

struct UserDefaultsStorage: View {
    @AppStorage("settings") private var settingsData: Data = Data()
    @State private var output: String = ""
    var body: some View {
        VStack {
            
            Text(output)
            Button("Load from App Storage") {
                guard let settings = try? JSONDecoder().decode(Settings.self, from: settingsData) else { return }
                output = "inNight: \(settings.inNight), name: \(settings.name)"
            }
            Button("Save in App Storage") {
                let settings = Settings(inNight: true, name: "Stive Job")
                
                guard let settingsDate = try? JSONEncoder().encode(settings) else { return }
                self.settingsData = settingsDate
            }
        }
    }
}

#Preview {
    UserDefaultsStorage()
}


//MARK: – Second variant save Data in array
class Record: Identifiable, Codable {
    var id = UUID()
    var name = "Anonumous"
    fileprivate(set) var isContacted = false
}

@MainActor class Records: ObservableObject {
    @Published private(set) var people: [Record]
    let saveKey = "SavedData"
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Record].self, from: data) {
                people = decoded
                return
            }
        }
        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func add(_ prospect: Record) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Record) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func delete(_ prospect: Record) {
            objectWillChange.send()
            if let index = people.firstIndex(where: { $0.id == prospect.id }) {
                people.remove(at: index)
                save()
            }
        }
}

struct ArrayStorage: View {
    @ObservedObject var prospects: Records
    var body: some View {
        VStack {
            List(prospects.people) { prospect in
                HStack {
                    Text(prospect.name)
                    Spacer()
                    Button(action: {
                        prospects.toggle(prospect)
                    }) {
                        if prospect.isContacted {
                            Text("NO")
                        } else {
                            Text("YES")
                        }
                    }
                    Spacer()
                    Button("Delete") {
                        prospects.delete(prospect)
                    }
                }
            }
            
            Button("Save in App Storage") {
                let person = Record()
                prospects.add(person)
            }
        }
    }
}

#Preview {
    ArrayStorage(prospects: .init())
}

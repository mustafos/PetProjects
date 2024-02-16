//
//  AccountView.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 17.03.2023.
//

import SwiftUI

struct AccountView: View {
    @State var isPinned = false
    @State var isDeleted = false
    @ObservedObject var updates = Updates() // If StateObject doesn't update the view, use ObservedObject
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("isLiteMode") var isLiteMode = true
    @State var address: Address = Address(id: 1, country: "Czechia")
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    profile
                }
                
                Section {
                    NavigationLink {} label: {
                        Label("Settings", systemImage: "gear")
                    }
                    
                    NavigationLink {} label: {
                        Label("Billing", systemImage: "creditcard")
                    }
                    
                    NavigationLink {} label: {
                        Label("Help", systemImage: "questionmark.circle")
                    }
                }
                .listRowSeparator(.automatic)
                
                Section {
                    Toggle(isOn: $isLiteMode) {
                        Label("Lite Mode", systemImage: isLiteMode ? "tortoise" : "hare")
                    }
                }
                
                linksSection
                
                updatesSection
                
                Button {} label: {
                    Text("Sign out")
                        .frame(maxWidth: .infinity)
                }
                .tint(.red)
                .onTapGesture {
                    isLogged = false
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .task {
                await fetchAddress()
                await updates.fetchUpdates()
            }
            .refreshable {
                await fetchAddress()
                await updates.fetchUpdates()
            }
        }
    }
    
    var updatesSection: some View {
        Section(header: Text("Updates")) {
            ForEach(updates.items) { item in
                HStack {
                    AsyncImage(url: URL(string: item.logo)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 32, height: 32)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.coin_name)
                        Text(item.acronym)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    var linksSection: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://mustafos.github.io")!) {
                    HStack {
                        Label("Website", systemImage: "house")
                            .tint(.primary)
                        Spacer()
                        Image(systemName: "link")
                            .tint(.secondary)
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        withAnimation {
                            isPinned.toggle()
                        }
                    } label: {
                        if isPinned {
                            Label("Unpin", systemImage: "pin.slash")
                        } else {
                            Label("Pin", systemImage: "pin")
                        }
                    }
                    .tint(isPinned ? .gray : .yellow)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        withAnimation {
                            isDeleted.toggle()
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
            
            Link(destination: URL(string: "https://www.youtube.com/@mustafos/featured")!) {
                HStack {
                    Label("YouTube", systemImage: "tv")
                        .tint(.primary)
                    Spacer()
                    Image(systemName: "link")
                        .tint(.secondary)
                }
            }
        }
        .listRowSeparator(.automatic)
    }
    
    var profile: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3), .red)
                .font(.system(size: 32))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(AnimatedBlobView().frame(width: 400, height: 414).offset(x: 200, y: 0).scaleEffect(0.5))
                .background(HexagonView().offset(x: -50, y: -100))
            Text("Mustafa Bekirov")
                .font(.title.weight(.semibold))
            Text(address.country)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func fetchAddress() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/address/random_address")!
            let (data, _) = try await URLSession.shared.data(from: url)
            address = try JSONDecoder().decode(Address.self, from: data)
        } catch {
            address = Address(id: 1, country: "Error fetching")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct Address: Identifiable, Decodable {
    var id: Int
    var country: String
}

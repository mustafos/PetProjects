//
//  GalleryView.swift
//  LazyLoadGallery
//
//  Created by Mustafa Bekirov on 28.05.2024.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var networkManager = NetworkManager()
    @State private var isPreloadHomeScreen = false
    var body: some View {
        if isPreloadHomeScreen {
            NavigationStack {
                ZStack {
                    List(networkManager.posts, id: \.self) { item in
                        PostRow(post: item)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .listStyle(.plain)
                    .buttonStyle(.plain)
                    .scrollIndicators(.hidden)
                    
                    if networkManager.inProgress {
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .scaleEffect(1.5)
                    }
                }
                .navigationTitle("Gallery")
                .alert(isPresented: $networkManager.showError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(networkManager.errorMessage),
                        primaryButton: .default(Text("Retry")) {
                            networkManager.retryFetch()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        } else {
            PreloaderView()
                .task {
                    await networkManager.fetchAllEmployees()
                }
        }
    }
    
    @ViewBuilder
    func PostRow(post: Post) -> some View {
        VStack(alignment: .leading) {
            CacheAsyncImage(image: post.imageURL)
            Text(post.title)
                .font(.headline)
                .bold()
                .padding(.horizontal, 10)
            
            Text(post.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
                .padding(.horizontal, 10)
        }
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func PreloaderView() -> some View {
        ProgressView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isPreloadHomeScreen = true
                }
            }
    }
}

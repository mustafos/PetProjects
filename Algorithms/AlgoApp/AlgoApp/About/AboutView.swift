//
//  AboutView.swift
//  AlgoApp
//
//  Created by Mustafa Bekirov on 03.02.2025.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    private let socialLinks: [(String, URL)] = [
        ("GitHub @mustafos", URL(string: "https://github.com/mustafos")!),
        ("LinkedIn", URL(string: "https://www.linkedin.com/in/mustafabekirov/")!),
        ("𝕏 @BekirovTech", URL(string: "https://x.com/BekirovTech")!)
    ]
    
    var body: some View {
        #if os(iOS)
        NavigationStack {
            aboutContent
                .navigationTitle("About")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
        }
        #elseif os(visionOS)
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    dismiss()
                }
                .padding()
            }
            aboutContent
        }
        .frame(width: 400, height: 500)
        #elseif os(macOS)
        VStack {
            aboutContent
        }
        .frame(width: 300, height: 400)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") {
                    dismiss()
                }
            }
        }
        #endif
    }
    
    private var aboutContent: some View {
        VStack(spacing: 20) {
            Image(systemName: "chart.bar.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text("Sorting Visualizer")
                .font(.title)
                .bold()
            
            Text("by Pedro Rojas (Pitt)")
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(socialLinks, id: \.0) { link in
                    Button {
                        openURL(link.1)
                    } label: {
                        HStack {
                            Text(link.0)
                                .foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    if link.0 != socialLinks.last?.0 {
                        Divider()
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
                    .shadow(radius: 2)
            }
            .padding(.horizontal)
            
            Text("Version 0.1")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .padding()
        .frame(maxWidth: 400)
    }
}

#Preview {
    AboutView()
}

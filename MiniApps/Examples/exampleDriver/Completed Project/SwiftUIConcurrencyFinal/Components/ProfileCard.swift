//
//  ProfileCard.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-22.
//

import SwiftUI

struct ProfileCard: View {
    var user: User
    @State private var showSafari: Bool = false
    let description = Description(content: "I am Leanne Graham")
    @State private var userDescription: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            HStack(alignment: .center, spacing: 16.0) {
                profilePicture
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            
            Text(userDescription)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(3)
            
            Divider().background(Color.white.opacity(0.2))
            
            HStack {
                Image(systemName: "link")
                    .opacity(0.7)
                Text(user.website)
                    .font(.footnote)
                    .opacity(0.7)
                
                
            }
            .onTapGesture {
                showSafari.toggle()
            }
        }
        .foregroundColor(.white)
        .padding(20)
        .frame(maxWidth: 512)
        .background(Color.init(hex: "281B5A").opacity(0.5))
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), lineWidth: 1)
                .blendMode(.overlay)
        )
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0.1647058824, green: 0.1098039216, blue: 0.3568627451, alpha: 1)).opacity(0.5), radius: 30, x: 0, y: 15)
        .fullScreenCover(isPresented: $showSafari) {
            SFSafariViewWrapper(url: URL(string: "https://\(user.website)")!)
        }
        .task {
            await description.update(with: "I love design and code")
            userDescription = await description.content
        }
    }
    
    var profilePicture: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3960784314, green: 0.5254901961, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.2509803922, blue: 0.3137254902, alpha: 1)), Color(#colorLiteral(red: 0.4274509804, green: 1, blue: 0.7254901961, alpha: 1)), Color(#colorLiteral(red: 0.1529411765, green: 0.9098039216, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.3960784314, green: 0.5254901961, blue: 1, alpha: 1))]), center: .center)
                .mask(Image(systemName: "circle.fill").font(.system(size: 66)))
                .frame(width: 66, height: 66)
                .blur(radius: 10)
                .overlay(
                    Circle()
                        .stroke(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), style: StrokeStyle(lineWidth: 2))
                        .blendMode(.overlay)
                        .background(Color.init(hex: "281B5A").opacity(0.5).mask(Circle()))
                )
            
            Image(systemName: "person.crop.circle")
                .foregroundColor(.primary)
                .frame(width: 66, height: 66, alignment: .center)
                .cornerRadius(50)
        }
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        let previewAddress = User.Address(street: "Coder St", suite: "200", city: "Developer City", zipcode: "90566-7771", geo: User.Address.Geo(lat: "-43.9509", lng: "-34.4618"))
        
        let previewCompany = User.Company(name: "Design+Code", catchPhrase: "Design and code", bs: "Learn design and code")
        
        let previewUser = User(id: 1, name: "Stephanie Diep", username: "stephdiep", email: "stephanie@designcode.io", address: previewAddress, phone: "123-456-7890", website: "designcode.io", company: previewCompany)

        ProfileCard(user: previewUser)
    }
}

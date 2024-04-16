//
//  AlamofireJSONParsingView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 15.04.2024.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

struct AlamofireJSONParsingView: View {
    @ObservedObject var manager = Manager()
    
    var body: some View {
        NavigationView {
            List(manager.datas) { i in
                Card(name: i.name, url: i.url)
            }
            .navigationTitle("JSON Parse")
        }
    }
}

#Preview {
    AlamofireJSONParsingView()
}

class Manager: ObservableObject {
    @Published var datas = [DataType]()
    
    init() {
        AF.request("https://api.github.com/users/hadley/orgs").responseData { (data) in
            let json = try! JSON(data: data.data!)
            
            for i in json {
                self.datas.append(DataType(id: i.1["id"].intValue, name: i.1["login"].stringValue, url: i.1["avatar_url"].stringValue))
                
                print(i.1["node_id"].stringValue)
            }
        }
    }
}

struct DataType: Identifiable {
    var id: Int
    var name: String
    var url: String
}

struct Card: View {
    var name = ""
    var url = ""
    
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .shadow(radius: 20)
            
            Text(name)
                .fontWeight(.heavy)
        }
    }
}

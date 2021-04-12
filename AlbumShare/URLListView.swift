//
//  URLListView.swift
//  CupcakeCorner
//
//  Created by vincent schmitt on 07/12/2020.
//

import SwiftUI
/*
struct URLListView: View {
    @State private var results = [Result]()

    func loadData() {
        guard let url = URL(string: //"https://itunes.apple.com/search?term=taylor+swift&entity=song"
            //"https://itunes.apple.com/search?term=edith+piaf&entity=song"
            "http://127.0.0.1:8888/test/swiftUI_save_image/18-12-2020.json"
            //"https://localhost:8888/test/swiftUI_save_image/18-12-2020.json"
                ) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.results
                    }
                    
                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    var body: some View {
        List(results, id: \.id) { item in
        //List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text("\(item.id)")
                Text("\(item.path)")
                //Text(item.trackName).font(.headline)
                //Text(item.collectionName)
            }
            }
            .onAppear(perform: loadData)
    }
}

struct URLListView_Previews: PreviewProvider {
    static var previews: some View {
        URLListView()
    }
}


class User: ObservableObject, Codable {
    @Published var name = "Yoko M"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
}


struct Response: Codable {
    var results: [Result]

}

struct Result: Codable {
    //var trackId: Int
    //var trackName: String
    //var collectionName: String
    var id: Int
    var path: String
}
*/


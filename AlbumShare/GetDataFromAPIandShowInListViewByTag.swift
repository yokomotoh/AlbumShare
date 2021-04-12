//
//  GetDataFromAPIandShowInListViewByTag.swift
//  SwiftUIJSONListTutorial
//
//  Created by yoko on 25/12/2020.
//

import SwiftUI
import Combine

struct GetDataFromAPIandShowInListViewByTag: View {
    @ObservedObject var byComment = Comment()
    //@State var byComment = Comment() //String = "Pauline"
    @State var models: [ResponseModel] = []
    
    var filteredTasks: [ResponseModel] {
        return models.filter { $0.comment.contains(self.byComment.comment) }
    }
    
    var body: some View {
        
        // Create VStack
           //VStack {
               // now show in list
               // to show in list, model class must be identifiable
            
            //   List (self.models) { (model) in
            //if model.comment.contains(self.byComment) {
            List (filteredTasks) { (task) in
                
                   HStack {
                       // they are optional
                       //Text("\(model.id)").bold()
                        //Image(systemName: "applelogo").resizable().scaledToFill()
                        //Text(model.path)
                    //UrlImageView(urlString: model.path)
                    //Text(model.comment)
                    UrlImageView(urlString: task.path)
                    //Text(task.comment)
                   }
                //}
            }
           //}
           .onAppear(perform: {
               // send request to server
                
               guard let url: URL = URL(string: "http://localhost:8888/test/swiftUI_save_image/swiftui-get-data-from-api.php") else {
                   print("invalid URL")
                   return
               }
                
               var urlRequest: URLRequest = URLRequest(url: url)
               urlRequest.httpMethod = "GET"
               URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                   // check if response is okay
                    
                   guard let data = data else {
                       print("invalid response")
                       return
                   }
                    
                   // convert JSON response into class model as an array
                   do {
                       self.models = try JSONDecoder().decode([ResponseModel].self, from: data)
                   } catch {
                       print(error.localizedDescription)
                   }
                    
               }).resume()
           })
    }
}




// ResponseModel.swift
class ResponseModel: Codable, Identifiable {
    var id: String
    var path: String
    var comment: String
}





struct GetDataFromAPIandShowInListViewByTag_Previews: PreviewProvider {
    
    //var byCom: String? = "Pauline"
    
    static var previews: some View {
        GetDataFromAPIandShowInListViewByTag()
    }
}

//
//  ImageUploaderView.swift
//  UploadImageFromGallery
//
//  Created by vincent schmitt on 05/01/2021.
//

import SwiftUI

struct ImageUploaderView: View {
    
    //show image picker
    @State var showImagePicker: Bool = false
    
    //show selected image
    @State var selectedImage: UIImage? = UIImage(contentsOfFile: "")
    @State var image: Image? = Image(systemName: "photo")
    //@State private var inputImage: UIImage?
    @State var commentStr: String = ""
    
    var body: some View {
        NavigationView{
            Form {
            // create button to select image
            Button(action: {
                self.showImagePicker.toggle()
            }, label: {
                Text("Select image")
            })
            
            // show image
            image?
            //self.selectedImage?
            .resizable().scaledToFit()

            // add comment
            TextField("Enter comment", text: $commentStr)
            
            // show button to upload image
            Button(action: {
                // convert image into base 64
                let uiImage: UIImage =
                    self.selectedImage ?? UIImage(contentsOfFile: "")!
                // load image to convert .jpg
                //let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
                // load image to convert .jpg
                let imageData: Data = uiImage.pngData() ?? Data()
                
                let imageStr: String = imageData.base64EncodedString()
                print(imageStr.lengthOfBytes(using: .utf8))
                //print("imageStr=\(imageStr)")
                // send request to server
                guard let url: URL = URL(string:
                        // load .jpeg in test/
                        //"http://localhost:8888/test/swiftui_save_image/swiftui_save_image.php"
                        // load to mysql
                        //"http://localhost:8888/test/swiftui_save_image/input.php"
                        // load with comment to mysql
                        "http://127.0.0.1:8888/test/swiftUI_save_image/inputComment.php"
                        // load to xrea
                        //"http://150.95.9.42:3306/test/swiftUI_save_image/inputComment.php"
                        //"http://150.95.9.42:3306/inputComment.php"
                        //"http://www.vinsfinsmotohama.shop/test/swiftUI_save_image/inputComment.php"
                        //"http://150.95.9.42/test/swiftUI_save_image/inputComment.php"
                        //"http://vinsfinsmotohama.s205.xrea.com/test/swiftUI_save_image/inputComment.php"
                        //"http://vinsfinsmotohama.s205.xrea.com/inputComment.php"
                        //"http://vinsfinsmotohama.s205.xrea.com/canvas-upload.php"
                        ) else {
                    print("invalid URL")
                    return
                
                // removed by yoko 4Jan2021
                //loadPng()
                }
                
                // create parameters
                // for save jpg
                let paramStr: String = "image=\(imageStr)"
                //let paramStr: String = "imageStr=\(imageStr)"
  
                //image and comment
                //let paramStr: String = "imageStr=\(imageStr)& commentStr=\($commentStr)"
                
                //// let paramStr: String = "commentStr=\(commentStr)&imageStr=\(imageStr)"
                //print(paramStr.lengthOfBytes(using: .utf8))
                //print("paramStr=\(paramStr)")

                let paramData: Data = //paramStr.data(using: .utf8) ?? Data()
                    paramStr.data(using: .utf8)!

                var urlRequest: URLRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                
                /* modified 22jan2021*/
                //urlRequest.httpBody = paramData
                
                let parameters: [String: Any] = [
                    "image": "\(imageStr)",
                    "commentStr": "\(commentStr)"
                    //"name": "Jack & Jill"
                ]
                print(parameters["commentStr"]!)
                //print(parameters["image"]!)
                urlRequest.httpBody = parameters.percentEncoded()
                /* modified 22jan2021 end */
                
                // required for sending large data
                
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                // send the request
                URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                    /*
                    //ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
                    if let error = error {
                        print("クライアントエラー: \(error.localizedDescription) \n")
                            return
                    }

                    guard let data = data, let response = response as? HTTPURLResponse else {
                            print("no data or no response")
                            return
                    }

                    if response.statusCode == 200 {
                            print(data)
                    } else {
                    //レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                    print("サーバエラー ステータスコード: \(response.statusCode)\n")
                        }
                    */
                    
                    guard let data = data else {
                        print("invalid data")
                        return
                    }
                    

                //show response in string
                let responseStr: String = String(data: data, encoding: .utf8)!// ?? ""
                print("responseStr of \(commentStr) :  \(responseStr) \n")

                })
                .resume()
                //self.image = Image(systemName: "photo")
                //self.commentStr = ""
                
            }, label: {
                Text("Upload image")
            })
            
        }
        .navigationBarTitle("Upload Image")
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
            ImagePicker(image: self.$selectedImage, sourceType: .photoLibrary)
            //ImagePicker(image: self.$inputImage)
        })
    }
    }
    func loadImage() {
/*
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
*/
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
}

struct ImageUploaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploaderView()
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

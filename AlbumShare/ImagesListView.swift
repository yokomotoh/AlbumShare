//
//  ImagesListView.swift
//  SwiftUIJSONListTutorial
//
//  Created by vincent schmitt on 05/01/2021.
//

import SwiftUI

struct ImagesListView: View {
    //@State var inputComment: String = "Romain"
    @ObservedObject var inputComment =   Comment()
    //@State var inputComment: Comment
    @State private var isShowingDetailView = false
    @State private var selection: String? = nil
    @State var showingDetail = false
    var body: some View {    NavigationView{
            GetDataFromAPIandShowInListViewByTag(byComment: inputComment)

                .navigationBarTitle(self.inputComment.comment, displayMode: .inline)
 
                .navigationBarItems(trailing:
                    Button(action: {self.showingDetail.toggle()}, label: {
                    Image(systemName: "gearshape")
                    })
                    )
        }
        .sheet(isPresented: $showingDetail) {
        DetailView(iComment: self.inputComment, isPresented: self.$showingDetail)
        //AddView()
    }
    //.onAppear {
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    //        self.isShowingDetailView = false
    //        }
    //    }
    
    /*
    TabView {
        GetDataFromAPIandShowInListViewByTag(byComment: "Pauline")
        //Text("Pauline")
            .tabItem {
                Image(systemName: "1.circle")
                Text("Pauline")
            }.tag(0)
        GetDataFromAPIandShowInListViewByTag(byComment: "Clement")
        //Text("Clement")
            .tabItem {
                Image(systemName: "2.circle")
                Text("Clement")
            }.tag(1)
    }
    */

    //URLListView()
    //GetDataFromAPIandShowInListView()
}
}

struct ResultView: View {
var choice: String

var body: some View {
Text("You chose \(choice)")
}
}

struct DetailView: View {
    @ObservedObject var iComment: Comment
    @State private var comment = ""
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            Form {
        //Text("key tag")
        //Text("\(iComment.comment)")
        
        TextField("Enter Name", text: $comment)

            Button("Save") {
                self.iComment.comment = self.comment
                self.isPresented = false
            }
            }
            .navigationBarTitle("Keyword")
        }
    }
}

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
        }
    }
}

class Comment: ObservableObject {
    @Published var comment: String = "Romain"
}
/*
struct Comment: ObservableObject {
    let comment: String = "Romain"
}
*/
struct ImagesListView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesListView(inputComment: Comment())
    }
}

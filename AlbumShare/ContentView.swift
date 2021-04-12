//
//  ContentView.swift
//  AlbumShare
//
//  Created by vincent schmitt on 05/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ImagesListView()
            //Text("Pauline")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("View Album")
                }.tag(0)
            ImageUploaderView()
            //Text("Clement")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Upload Image")
                }.tag(1)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

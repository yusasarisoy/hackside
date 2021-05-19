//
//  ContentView.swift
//  hackside
//
//  Created by Yuşa Sarısoy on 26.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    Text(String(post.points))
                        .foregroundColor(Color("Pumpkin"))
                        .fontWeight(.bold)
                    Text(post.title)
                        .fontWeight(.medium)
                }
            }
            .navigationBarTitle("Hackside")
        }
        .onAppear() {
            networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

struct ContentView: View {
  
  @ObservedObject private var networkManager = NetworkManager()
  
  var body: some View {
    NavigationView {
      List(networkManager.posts, id: \.objectID) { post in
        NavigationLink(destination: DetailView(url: post.url)) {
          Text(String(post.points ?? .zero))
            .foregroundColor(Color("Pumpkin"))
            .fontWeight(.bold)
          Text(post.title ?? "No title")
            .fontWeight(.medium)
        }
      }
      .navigationBarTitle("Hackside")
    }
    .task {
      do {
        try await networkManager.fetchData()
      } catch {
        // TODO: - Handle error.
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

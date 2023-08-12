import Combine
import Foundation

@MainActor
final class NetworkManager: ObservableObject {
  
  private enum URLConstants {
    static let url = "http://hn.algolia.com/api/v1/search?tags=front_page"
  }
  
  @Published var posts = [Post]()

  func fetchData() async throws {
    guard let url = URL(string: URLConstants.url) else { return }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error."
    }
    guard let results = try? JSONDecoder().decode(Results.self, from: data) else { return }
    posts = results.hits ?? []
  }
}

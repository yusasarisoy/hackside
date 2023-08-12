struct Results: Decodable {
    let hits: [Post]?
}

struct Post: Decodable {
    let objectID: String?
    let points: Int?
    let title: String?
    let url: String?
}

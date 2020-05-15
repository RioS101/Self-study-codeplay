import UIKit
import PlaygroundSupport

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

struct StoreItem: Codable {
    var artistName: String
    var collectionName: String
    var artworkURL: URL
    var country: String
    var genre: String
    
    enum CustomKeys: String, CodingKey {
        case artistName
        case collectionName
        case artworkURL = "artworkUrl100"
        case country
        case genre = "primaryGenreName"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case artworkUrl160
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CustomKeys.self)
        
        self.artistName = try values.decode(String.self, forKey: CustomKeys.artistName)
        self.collectionName = try values.decode(String.self, forKey: CustomKeys.collectionName)
        
        if let artworkURL = try? values.decode(URL.self, forKey: CustomKeys.artworkURL) {
            self.artworkURL = artworkURL
        } else {
            let alternativeValues = try decoder.container(keyedBy: AdditionalKeys.self)

            self.artworkURL = (try? alternativeValues.decode(URL.self, forKey: AdditionalKeys.artworkUrl160)) ?? URL(string: "example.com")!
        }
        
        self.country = try values.decode(String.self, forKey: CustomKeys.country)
        self.genre = try values.decode(String.self, forKey: CustomKeys.genre)
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true


let query: [String: String] = [
    "term" : "Michael+Jackson",
    "media" : "music",
    "entity" : "album"
]

struct StoreItems: Codable {
    let results: [StoreItem]
}

func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!

    guard let url = baseURL.withQueries(query) else {
        completion(nil)
        print("Unable to build URL with supplied queries")
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let storeItems = try? jsonDecoder.decode(StoreItems.self, from: data) {
            completion(storeItems.results)
        } else {
            print("The response was invalid, or could not be decoded properly")
            completion(nil)
            return
        }
    }

    task.resume()
}


//tak i ne razobralsya chto peredavat v completion
//fetchItems(matching: query, completion: <#T##([StoreItem]?) -> Void#>) vot eta vot xuyna

fetchItems(matching: query) { (completion) in
    print(completion!)
}

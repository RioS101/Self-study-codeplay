import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

//creating queries
let query: [String: String] = [
    "term":"Coldplay",
    "media":"music",
    "entity":"musicTrack"
]

struct StoreItem: Codable {
    let artistName: String
    let albumName: String
    //collectionName in api
    let trackName: String

    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName
        case trackName
    }

    enum additionalKeys: String, CodingKey {
        case collectionName
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)

        if let albumName = try? values.decode(String.self, forKey: CodingKeys.albumName) {
            self.albumName = albumName
        } else {
            let additionalValues = try decoder.container(keyedBy: additionalKeys.self)
            albumName = (try? additionalValues.decode(String.self, forKey: additionalKeys.collectionName)) ?? ""
        }
    }
}

func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
    //creating url itself
    let baseUrl = URL(string: "https://itunes.apple.com/search?")!

    
    //final url constructed form previous + queries
    guard let url = baseUrl.withQueries(query) else {
     completion(nil)
        print("Unable to build URL with supplied queries")
        return
    }

    //creating request
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        let decoder = JSONDecoder()
        if let data = data,
            let storeItems = try? decoder.decode(StoreItems.self, from: data) {
            completion(storeItems.results)
        } else {
         print("Either no data was returned, or data was not serialized")
            completion(nil)
            return
        }
    }

    //sending the request. After you create the task, you must start it by calling its resume() method.
    task.resume()
}

//intermediary
struct StoreItems: Codable {
    let results: [StoreItem]
}


//calling the function 
fetchItems(matching: query) { (storeItems) in
    print(storeItems!)
}


/* another version of implementation where  case albumName = "collectionName"
 
struct StoreItem: Codable {
    let artistName: String
    let albumName: String
    //collectionName in api
    let trackName: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case trackName
    }
    
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        albumName = try values.decode(String.self, forKey: CodingKeys.albumName)
    }
}
*/

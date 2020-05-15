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


let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!

let query: [String: String] = [
    "api_key": "DEMO_KEY",
    "date": "2011-07-13"
]


let url = baseURL.withQueries(query)!


//creating the request
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    let jsonDecoder = JSONDecoder()
    if let data = data,
        let photoDictionary = try? jsonDecoder.decode([String: String].self, from: data) {
        print(photoDictionary)
    }
    PlaygroundPage.current.finishExecution()
}

//sending the request
task.resume()


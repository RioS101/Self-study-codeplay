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

//creating url itself
let baseUrl = URL(string: "https://itunes.apple.com/search?")!

//creating queries
let query: [String: String] = [
    "term":"Hanz+Zimmer",
    "media":"music"
]

//final url constructed form previous + queries
let url = baseUrl.withQueries(query)!

//creating request
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data,
        let string = String(data: data, encoding: .utf8) {
        print(string)
    }
    PlaygroundPage.current.finishExecution()
}

//sending the request. After you create the task, you must start it by calling its resume() method.
task.resume()

/*
 https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo
 
 This is an example of what I've done above. Just for illustration how this looks like in practice.
 In m situation it will look like this:
 https://itunes.apple.com/search?term=Hanz+Zimmer&media=music
 */

//https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/ see this site for documentation of searching API of itunes store.

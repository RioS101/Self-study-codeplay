//
//  PhotoInfoController.swift
//  SpacePhoto2
//
//  Created by Riad on 3/20/20.
//  Copyright © 2020 Projectum. All rights reserved.
//

import Foundation

class PhotoInfoController {
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!

        let query: [String: String] = [
            "api_key" : "DEMO_KEY"
        ]

        let url = baseURL.withQueries(query)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                print("The response was invalid, or could not be decoded properly")
                completion(nil)
                return
            }
        }

        task.resume()
    }

}

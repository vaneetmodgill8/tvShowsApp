//
//  Utility+Cache.swift
//  TVShowsApp
//
//  Created by Vaneet Modgill on 13/01/23.
//

import UIKit

extension UIImageView {
    func getImage(url: String, placeholderImage: UIImage? = nil) {
        guard let url = URL(string: url)  else {
            return
        }
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let cachedData = cache.cachedResponse(for: request)?.data, let cachedImage = UIImage(data: cachedData) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        self.image = placeholderImage
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? Int.max) < 300, let image = UIImage(data: data) {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedResponse, for: request)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }).resume()
    }
    
}

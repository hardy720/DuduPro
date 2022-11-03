//
//  UIImageView+PGCache.swift
//  Pods
//
//  Created by piggybear on 2017/7/11.
//
//

import UIKit

public extension UIImageView {
    public func imageWithURL(url: URL, placeholderImage placeholder: UIImage?) {
        self.image = placeholder
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache.shared
        configuration.requestCachePolicy = .useProtocolCachePolicy
        let session = URLSession(configuration: configuration)
        var request = URLRequest(url: url)
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        request.httpShouldUsePipelining = true
        session.dataTask(with: request) { (data, response, error) in
            guard (error != nil) else {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
        }.resume()
        
    }
}

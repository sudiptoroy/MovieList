//
//  LoadImage.swift
//  BrainStation-Test
//
//  Created by Sudipto Roy on 5/6/21.
//  Copyright © 2021 Code_X Systems. All rights reserved.
//

import Foundation
import UIKit


class LoadImageView: UIImageView {
    
    /// Object to cache image
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    
    
    
    // MARK: - DownLoad from URL
    
    /// Download image from URL type
    /// - Parameters:
    ///   - url: image url
    ///   - mode: UIView contentMode. Default to aspectfit.
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        if let cachedImage = self.imageCache.object(forKey: url as AnyObject) {
            //debugPrint("Image Loaded from cache: \(url)")
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                //debugPrint("Image downloaded from server...")
                self?.imageCache.setObject(image, forKey: url as AnyObject)
                self?.image = image
            }
        }.resume()
    }
    
    
    
    
    // MARK: - Download from string type
    
    /// Download image from string type
    /// - Parameters:
    ///   - link: image link as string
    ///   - mode: UIView content mode. default to aspectFit
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}

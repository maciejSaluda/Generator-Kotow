//
//  APIService.swift
//  testapp
//
//  Created by Maciej Sałuda on 23/06/2022.
//

import UIKit

struct APIService {
    
    static func loadFrom(URLAddress: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url) {
                let loadedImage = UIImage(data: imageData)
                if let image = loadedImage {
                    completion(image)
                }
            }
        }
    }
}

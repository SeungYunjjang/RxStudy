//
//  UIExtension.swift
//  RxStudy
//
//  Created by andrew on 2020/01/02.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit


//MARK: - Dictionary
extension Dictionary {
    
    func queryString() -> String? {
         guard self.count > 0  else { return nil }
         var components = URLComponents()
         var queryItems = Array<URLQueryItem>()
         
         if let queryData = self as? Dictionary<String, Any?> {
             for (key, value) in queryData {
                 guard let _value = value else { continue }
                 switch _value {
                 case is String, is Int, is Bool, is Double, is Float, is NSNumber, is NSString:
                     queryItems.append(URLQueryItem(name: key, value: "\(_value)"))
                 default:
                     break
                 }
             }
             
             components.queryItems = queryItems
             return components.query
         }
         
         return nil
     }
}


//MAKR: - UIImage
extension UIImage {
    
    func setUrlImage(_ url: String) -> UIImage {
        
        guard let url = URL(string: "\(ApiUrls.shared.getImageUrl(url))"),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
            else {
                return #imageLiteral(resourceName: "no_image")
        }
        
        return image
    }
    
}



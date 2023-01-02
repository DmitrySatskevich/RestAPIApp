//
//  NetworkService.swift
//  RestAPIApp
//
//  Created by dzmitry on 29.12.22.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    
    static func deletePost(postID: Int,
                           callback: @escaping (_ result: JSON?, _ error: Error?) -> Void)
    {
        let url = ApiConstants.postsPath + "/" + "\(postID)"
        
        // уходим в другой поток
        AF.request(url, method: .delete)
            .response { response in
            
            var jsonValue: JSON?
            var err: Error?
            
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                jsonValue = JSON(data)
            case .failure(let error):
                err = error
            }
            callback(jsonValue, err)
        }
    }
    
    static func getPhotos(albomID: Int,
                          callback: @escaping (_ result: [JSON]?, _ error: Error?) -> Void) {
        let url = ApiConstants.photosPath + "?" + "albumId=\(albomID)"
        
        // уходим в другой поток
        AF.request(url).response
        { response in
            var jsonValue: [JSON]?
            var err: Error?
            
            switch response.result
            {
            case .success(let data):
                guard let data = data else { return }
                jsonValue = JSON(data).arrayValue
            case .failure(let error):
                err = error
            }
            callback(jsonValue, err)
        }
    }
}

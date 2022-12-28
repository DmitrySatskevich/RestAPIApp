//
//  NewPostVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 28.12.22.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewPostVC: UIViewController {
    
    var user: User?

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    
   
    @IBAction func postURLSession() {
        if let userId = user?.id,
           let title = titleTF.text,
           let text = bodyTV.text,
           let url = ApiConstants.postsPathURL
        {
            // SETUP request
            var request = URLRequest(url: url)
            
            // HEDER
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // BODY
            let postBodyJson: [String: Any] = ["userId": userId,
                                               "title": title,
                                               "body": text]
            
            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJson, options: [])
            request.httpBody = httpBody
            
            // Create dataTask and post new request
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response ?? "")
                if let data = data {
                    // библиотека SwiftyGSON
                    print(data)
                    let json = JSON(data)
                    print(json)
                    let userId = json["userId"].int
                    let title = json["title"].string
                    let body = json["body"].string
                    
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                } else if let error = error {
                    print(error)
                }
            }.resume()
        }
    }
    
    // библиотека Alamofire
    @IBAction func postAlamofire() {
        if let userId = user?.id,
           let title = titleTF.text,
           let text = bodyTV.text,
           let url = ApiConstants.postsPathURL
        {
            let parameters: Parameters = ["userId": userId,
                                          "title": title,
                                          "body": text]
            
            AF.request(url,
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default).response { response in
                debugPrint(response)
                print(response.request ?? "")
                print(response.response ?? "")
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    print(data ?? "")
                    print(JSON(data ?? ""))
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

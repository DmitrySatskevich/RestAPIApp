//
//  ImageVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 21.12.22.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let imageURLStr = "https://images.wallpapersden.com/image/download/lofoten-sunrise-near-sea-mountains-norway-island_a2ZuZWaUmZqaraWkpJRsa21lrWloZ2U.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
   
    private func fetchImage() {
        guard let url = URL(string: imageURLStr) else { return }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.main.async {
                
                self.activityIndicatorView.stopAnimating()
                
                if let error = error {
                    print(error.localizedDescription)
                    // здесь можно добавить дефолтную картинку или отобразить ошибку (alert)
                    return
                }
                if let response = response {
                    print(response)
                }
                
                print("\n", data ?? "", "\n")
                
                if let data = data,
                   let image = UIImage(data: data) {
                    self.image.image = image
                } else {
                    // если что-то не получилось, можно тоже добавить что-либо (alert) и т.д
                }
            }
        }//.resume()
        task.resume()
    }
}

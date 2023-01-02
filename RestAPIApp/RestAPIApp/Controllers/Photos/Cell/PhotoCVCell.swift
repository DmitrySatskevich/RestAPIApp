//
//  PhotoCVCell.swift
//  RestAPIApp
//
//  Created by dzmitry on 2.01.23.
//

import UIKit
import Alamofire
import AlamofireImage

final class PhotoCVCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var thumbnailUrl: String? {
        didSet {
            getThumbnail()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func getThumbnail() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        AF.request(thumbnailUrl).responseImage { [weak self] response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            
            if case .success(let image) = response.result {
                print("image dounloaded: \(image)")
                
                self?.activityIndicatorView.stopAnimating()
                self?.imageView.image = image
            }
        }
    }
}

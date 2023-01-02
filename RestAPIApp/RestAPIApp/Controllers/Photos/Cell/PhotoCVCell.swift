//
//  PhotoCVCell.swift
//  RestAPIApp
//
//  Created by dzmitry on 2.01.23.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCVCell: UICollectionViewCell {

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
    
    // если картинка(объект) не загружается из кэш, тогда грузим из сервера
    private func getThumbnail() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        NetworkService.getPhoto(imageURL: thumbnailUrl) { [weak self]  image, error in
            self?.activityIndicatorView.stopAnimating()
            self?.imageView.image = image
        }
    }
}

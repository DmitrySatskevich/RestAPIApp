//
//  PhotosCVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 2.01.23.
//

import UIKit
import SwiftyJSON

class PhotosCVC: UICollectionViewController {
    
    var user: User!
    var album: JSON!
    var photos: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album?["title"].string
        collectionView.register(UINib(nibName: "PhotoCVCell", bundle: .main),
                                forCellWithReuseIdentifier: "PhotoCVCell")
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sizeWH = (UIScreen.main.bounds.width / 2) - 5
        let UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        UICollectionViewFlowLayout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout
    }
    
    func getData() {
        if let album,
           let albumID = album["id"].int {
            NetworkService.getPhotos(albomID: albumID) { [weak self] response, _ in
                guard let photos = response else { return }
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVCell", for: indexPath) as! PhotoCVCell
        cell.thumbnailUrl = photos[indexPath.row]["thumbnailUrl"].string
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoVC,
           let photo = sender as? JSON {
            photoVC.photo = photo
        }
    }
}

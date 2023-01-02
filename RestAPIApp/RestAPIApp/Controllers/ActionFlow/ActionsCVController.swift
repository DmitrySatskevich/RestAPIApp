//
//  ActionsCVController.swift
//  RestAPIApp
//
//  Created by dzmitry on 21.12.22.
//

import UIKit

// CaseIterable позволяет из перечисления сделать массив
enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

class ActionsCVController: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ActionCVCell else { return UICollectionViewCell() }
        cell.infoLbl.text = userActions[indexPath.row].rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "DownloadImageSegue", sender: nil)
        case .users: performSegue(withIdentifier: "UsersSegue", sender: nil)
        }
    }
}

extension ActionsCVController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20), height: 80)
    }
}

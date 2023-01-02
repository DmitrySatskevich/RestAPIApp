//
//  AlbomsTVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 29.12.22.
//

import UIKit
import SwiftyJSON
import Alamofire

class AlbomsTVC: UITableViewController {
    
    var user: User!
    var albums: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {

        guard let userId = user?.id else { return }
        
        guard let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userId)") else { return }

        AF.request(url).response { response in
            
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                self.albums = JSON(data).arrayValue
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = albums[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
           let photoCollectionVC = segue.destination as? PhotosCVC,
           let album = sender as? JSON {
            photoCollectionVC.user = user
            photoCollectionVC.album = album
        }
    }
}

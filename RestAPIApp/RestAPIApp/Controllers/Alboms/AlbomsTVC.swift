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
    var alboms: [JSON] = []

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
                self.alboms = JSON(data).arrayValue
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alboms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = (alboms[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = alboms[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

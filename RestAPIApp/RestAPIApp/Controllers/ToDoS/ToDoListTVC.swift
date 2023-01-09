//
//  ToDoListTVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 7.01.23.
//

import UIKit
import SwiftyJSON
import Alamofire

class ToDoListTVC: UITableViewController {
    
    var user: User!
    var todos: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    private func getData() {
        guard let userId = user?.id else { return }
        
        guard let url = URL(string: "\(ApiConstants.todosPath)?userId=\(userId)") else { return }
        
        AF.request(url).response { response in
            
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                self.todos = JSON(data).arrayValue
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (todos[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = todos[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}

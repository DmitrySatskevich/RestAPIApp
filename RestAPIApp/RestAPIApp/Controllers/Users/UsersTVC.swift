//
//  UsersTVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 25.12.22.
//

import UIKit

class UsersTVC: UITableViewController {
    
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUsers()
        
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.username
        return cell
    }

   // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailUserVC") as! DetailUserVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            do {
                self?.users = try JSONDecoder().decode([User].self, from: data)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }
}

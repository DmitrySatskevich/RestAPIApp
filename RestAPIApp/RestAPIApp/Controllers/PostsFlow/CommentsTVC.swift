//
//  CommentsTVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 26.12.22.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var postID: Int?
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComments()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let comment = comments[indexPath.row]
        cell.textLabel?.text = comment.email
        cell.detailTextLabel?.text = comment.body
        return cell
    }

    func fetchComments() {
        guard let postID else { return }
        let pathUrl = "\(ApiConstants.commentsPath)?postId=\(postID)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
                print(self.comments)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}

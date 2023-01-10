//
//  DetailUserVC.swift
//  RestAPIApp
//
//  Created by dzmitry on 25.12.22.
//

import UIKit

class DetailUserVC: UIViewController {

    var user: User?
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var username: UILabel!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var phone: UILabel!
    @IBOutlet private weak var website: UILabel!
    @IBOutlet private weak var geo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    @IBAction func postsAction() {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albomsAction() {
        let storyboard = UIStoryboard(name: "AlbomsAndFotos", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbomsTVC") as! AlbomsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todosAction() {
        let storyboard = UIStoryboard(name: "ToDoList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ToDoListTVC") as! ToDoListTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        name.text = user?.name
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        website.text = user?.website
        geo.text = "\(user?.address?.geo?.lat ?? "_") \(user?.address?.geo?.lng ?? "_")"
    }

}

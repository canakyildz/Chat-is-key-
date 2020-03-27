//
//  newMessageController.swift
//  Chat is key!
//
//  Created by Apple on 18.03.2020.
//  Copyright © 2020 PHYSID. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: class {
    func controller(_ controller: newMessageController, wantsToStartChatWith user: User)
}

class newMessageController: UITableViewController {
    
    //MARK: - Properties
    
    private var users = [User]()
    weak var delegate: NewMessageControllerDelegate? //we made this weak we have to set this delegate variable and we are setting it to be an instance of the convo controller. we made it wear we dont wanna have retained cycle where we have two strong references of that view controller.
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUsers()
    }
    
    // MARK: - Selectors
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    func fetchUsers() {
        Service.fetchUser { (users) in
            self.users = users
            self.tableView.reloadData() //things take time while fetching data. 
            
        } //we dont have do use share anymore because we are using static func.you can also make your service static but no need since just one thing will happen.
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        
        
        tableView.tableFooterView = UIView() //lets get rid of useles dividers
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        
    }
    
    }

    // MARK: - UITableViewDataSource

extension newMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell //we casted it to have access to properties in that cell.
        cell.user = users[indexPath.row]
        return cell
    }
}

extension newMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
        
        }
        
    }


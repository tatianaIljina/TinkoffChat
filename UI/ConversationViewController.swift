//
//  ConversationViewController.swift
//  UI
//
//  Created by Татьяна Ильина on 07.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    
    @IBOutlet var tableConversation: UITableView!
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableConversation.delegate = self
        tableConversation.dataSource = self
    }
}

extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
}

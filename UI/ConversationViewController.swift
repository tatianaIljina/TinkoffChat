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
        
        makeMessage()
        
        tableConversation.delegate = self
        tableConversation.dataSource = self
    }
    private func makeMessage() {
        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: true))
        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: false))
        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: true))
        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: false))
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
        if messages[indexPath.row].isComing == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "comingCell", for: indexPath) as? MessageTableViewCell
            //cell.textMessage?.text = messages[indexPath.row]
            //return cell
        }
        return UITableViewCell()
    }
}

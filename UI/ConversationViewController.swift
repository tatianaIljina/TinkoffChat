//
//  ConversationViewController.swift
//  UI
//
//  Created by Татьяна Ильина on 07.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var tableConversation: UITableView!
    @IBOutlet var send: UIButton!
    @IBOutlet var messageTextField: UITextField!
    
    
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        tableConversation.delegate = self
        tableConversation.dataSource = self
        
        messageTextField.delegate = self
    }
    
//    private func makeMessage() {
//        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: true))
//        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: false))
//        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: true))
//        self.messages.append(Message(text:"Привет! Свободна сегодня в 20:00?", isComing: false))
//    }
    
    private func dismissKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
}

extension ConversationViewController: UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
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
    //keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

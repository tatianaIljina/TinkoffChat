//
//  File.swift
//  UI
//
//  Created by Татьяна Ильина on 06.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit
class ConversationsListViewController: UIViewController {
    
    @IBOutlet weak var tableConversations: UITableView!
    
    var onlineConversations = [Conversation]()
    var offlineConversations = [Conversation]()
    var allConversations = [[Conversation]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeData()
        self.tableConversations.delegate = self
        self.tableConversations.dataSource = self
        self.tableConversations.rowHeight = UITableView.automaticDimension
        //self.tableConversations.estimatedRowHeight = 100
    }


    
    func makeData(){
        self.onlineConversations.append(Conversation(name: "Мама", message: "Домой!", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Сестра", message: nil, date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Любимый", message: "Пришла зп", date: nil, online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Босс", message: "Где отчет?", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Шиян", message: "Hi", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Навельный", message: "Придешь на митинг?", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Макгрегор", message: "Хабиб лох", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "ХЗ кто", message: "Го гулять", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Гоша", message: nil, date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Серега", message: "Денег дашь? А то я тут такое пальто в магазине видел", date: getDate(), online: true, hasUnreadMessage: false))
        
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        self.offlineConversations.append(Conversation(name: "Олег", message: "Hi", date: getDate(), online: false, hasUnreadMessage: false))
        
        self.allConversations.append(onlineConversations)
        self.allConversations.append(offlineConversations)
        
    }
    
    private func getDate() -> Date? {
        
        let day = arc4random_uniform(2)+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
        
    }
    

}

extension ConversationsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return onlineConversations.count
            
        } else {
            return offlineConversations.count
        }
    }
    //готовим ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        
        let conversation = allConversations[indexPath.section][indexPath.row]
        
        cell.conversationConfiguration(configuration: conversation)
        //cell.nameLabel?.text = conversation.name
        //cell.messageLabel.text = conversation.message
        //cell.dateLabel.text = conversation.date
        return cell
    }
    //headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Online"
        } else {
            return "History"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationViewController = storyboard?.instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
        conversationViewController.title = allConversations[indexPath.section][indexPath.row].name
        navigationController?.pushViewController(conversationViewController, animated: true)
    }
}

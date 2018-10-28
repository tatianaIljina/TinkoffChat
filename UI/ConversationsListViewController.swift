//
//  File.swift
//  UI
//
//  Created by Татьяна Ильина on 06.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit
class ConversationsListViewController: UIViewController, ThemesViewControllerDelegate {
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        self.view.backgroundColor = selectedTheme
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //appDelegate.configureNavigationBar()
        logThemeChanging(selectedTheme: selectedTheme)
    }
    func logThemeChanging(selectedTheme: UIColor){
        print ("New theme was choosed: \(selectedTheme)")
    }
    
    
    @IBOutlet weak var tableConversations: UITableView!

    var onlineConversations = [Conversation]()
    var offlineConversations = [Conversation]()
    var allConversations = [[Conversation]]()
    
    @IBAction func onProfile(_ sender: Any) {
        performSegue(withIdentifier: "ShowProfile", sender: self)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let profileController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//        self.present(profileController, animated: true, completion: nil)
    }
    
    @IBAction func onChoosingThemes(_ sender: Any) {
        //performSegue(withIdentifier: "ShowThemes", sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let themeViewController = storyboard.instantiateViewController(withIdentifier: "ThemeViewController") as! ThemesViewController
        self.present(themeViewController, animated: true, completion: nil)
   }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeData()
        self.tableConversations.delegate = self
        self.tableConversations.dataSource = self
        self.tableConversations.rowHeight = UITableView.automaticDimension
        //self.tableConversations.estimatedRowHeight = 100
        //performSegue(withIdentifier: "ShowProfile", sender: self)
    }
    
    
    func makeData(){
        self.onlineConversations.append(Conversation(name: "Мама", message: "Домой!", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Сестра", message: nil, date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Любимый", message: "Как дела?", date: nil, online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Босс", message: "Где отчет?", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Друг", message: "Hi", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Олег", message: nil, date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Декан", message: "вы отчислены", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "ХЗ кто", message: "Го гулять", date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Гоша", message: nil, date: getDate(), online: true, hasUnreadMessage: false))
        self.onlineConversations.append(Conversation(name: "Серега", message: "Я тут такое пальто в магазине видел", date: getDate(), online: true, hasUnreadMessage: false))
        
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
    
    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == "ShowProfile"{
//            let segue = segue.destination as! ViewController
//        }
//            else {
//                super.prepare(for: segue, sender: sender)
//            }
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let themesViewController = (segue.destination as! UINavigationController).viewControllers.first as? ThemesViewController {
//            themesViewController.delegate = self
//        } else {
//        }
//    }
    
}


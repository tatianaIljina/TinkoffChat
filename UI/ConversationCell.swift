//
//  Cell.swift
//  UI
//
//  Created by Татьяна Ильина on 06.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell, ConversationCellConfiguration {
    
    var userId: String?
    var name: String?
    var message: String?
    var online: Bool = true
    var hasUnreadMessage: Bool = true
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var date: Date? {
        didSet {
            if message?.count != 0 {
                if let date = date {
                    
                    let curentDate = Date()
                    
                    let dateFormatter = DateFormatter()
                    let calendar = Calendar.current
                    if calendar.startOfDay(for: curentDate) == calendar.startOfDay(for: date) {
                        dateFormatter.dateFormat = "HH:mm"
                    } else {
                        dateFormatter.dateFormat = "dd MMM"
                    }
                    
                    self.dateLabel.text = dateFormatter.string(from: date)
                    
                }
            } else {
                self.dateLabel.text = ""
            }
        }
    }
    
    
    func conversationConfiguration(configuration: ConversationCellConfiguration){
        nameLabel.text = configuration.name
        self.date = configuration.date
        if configuration.message == nil{
            //let fontSize = self.messageLabel.font.pointSize
            //self.messageLabel.font = UIFont(name: "Roboto", size: fontSize)
            //messageLabel.text = "No messages yet"
        self.messageLabel.attributedText = NSAttributedString(string: "No messages yet", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: self.messageLabel.font.pointSize)])
        } else {
            messageLabel.text = configuration.message
        }
        //dateLabel.text = configuration.date
        if configuration.online {
            backgroundColor = UIColor(red:0.96, green:0.95, blue:0.71, alpha:1.0)
        }
    }
    

}

protocol ConversationCellConfiguration: class {
    
    var userId: String? {get set}
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessage: Bool {get set}
}

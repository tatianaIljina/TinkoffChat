//
//  Cell.swift
//  UI
//
//  Created by Татьяна Ильина on 06.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell, ConversationCellConfiguration {
    var name: String?
    var message: String?
    var date: Date?
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
    func conversationConfiguration(configuration: ConversationCellConfiguration){
        nameLabel.text = configuration.name
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
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessage: Bool {get set}
}

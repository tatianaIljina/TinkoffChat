//
//  MessageTableViewCell.swift
//  UI
//
//  Created by Татьяна Ильина on 07.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell, MessageCellConfiguration {
    var textMessage: String?
    var isComing: Bool?
    
    @IBOutlet weak var sendingMessageLabel: UILabel!
    @IBOutlet weak var comingMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
protocol MessageCellConfiguration: class {
    var textMessage : String? {get set}
    var isComing: Bool? {get set}
}

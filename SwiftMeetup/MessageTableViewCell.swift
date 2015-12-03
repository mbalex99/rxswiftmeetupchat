//
//  MessageTableViewCell.swift
//  SwiftMeetup
//
//  Created by Maximilian Alexander on 12/3/15.
//  Copyright © 2015 Epoque. All rights reserved.
//

import UIKit
import Cartography

class MessageTableViewCell: UITableViewCell {

    static let ReuseId = "MessageTableViewCell"
    
    var nameLabel : UILabel = UILabel()
    var contentLabel : UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 17.0)
        contentLabel.font = UIFont.systemFontOfSize(16)
        contentLabel.numberOfLines = 0
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(contentLabel)
        
        // constrain the view
        constrain(nameLabel, contentLabel) { nameLabel, contentLabel in
            nameLabel.height == 15
            nameLabel.left == nameLabel.superview!.left + 5
            nameLabel.top == nameLabel.superview!.top + 15
            nameLabel.right == nameLabel.superview!.right - 5
            
            contentLabel.top == nameLabel.bottom + 5
            contentLabel.left == contentLabel.superview!.left + 5
            contentLabel.right == contentLabel.superview!.right - 5
            contentLabel.bottom == contentLabel.superview!.bottom - 15
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

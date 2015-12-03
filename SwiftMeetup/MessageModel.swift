//
//  MessageModel.swift
//  SwiftMeetup
//
//  Created by Maximilian Alexander on 12/3/15.
//  Copyright © 2015 Epoque. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MessageModel {
    
    var name: String
    var content: String
    
    init(json : JSON) {
        name = json["name"].stringValue
        content = json["content"].stringValue
    }
    
    init(name: String, content: String){
        self.name = name
        self.content = content
    }
    
    func toJSON() -> JSON {
        return JSON([
                "name": name,
                "content": content
        ])
    }
    
}
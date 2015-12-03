//
//  ChatViewController.swift
//  SwiftMeetup
//
//  Created by Maximilian Alexander on 12/3/15.
//  Copyright © 2015 Epoque. All rights reserved.
//

import UIKit
import SlackTextViewController
import RxSwift
import Starscream
import SwiftyJSON

class ChatViewController: SLKTextViewController {

    var name : String
    var messages = [MessageModel]()
    
    var websocket: WebSocket!
    
    init(name: String){
        self.name = name
        super.init(tableViewStyle: UITableViewStyle.Plain)
    }

    required init!(coder decoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
    
        inverted = true
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.ReuseId)
        tableView.allowsSelection = false
        
        let stringMessageObservable : Observable<String> = create { (observer: AnyObserver<String>) -> Disposable in
            self.websocket = WebSocket(url: NSURL(string: AppDelegate.socketEndpoint)!)
            self.websocket.connect()
            self.websocket.onText = { text in
                observer.onNext(text)
            }
            self.websocket.onDisconnect = { error in
                if let err = error {
                    observer.onError(err)
                }
            }
            return AnonymousDisposable{
                self.websocket.disconnect()
            }
        }.retry()
        
        stringMessageObservable
            .map { (text) -> JSON in
                let dataFromString = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                let json = JSON(data: dataFromString!)
                return json
            }
            .map { (json) -> MessageModel in
                return MessageModel(json: json)
            }
            .subscribeNext { (messageModel) -> Void in
                self.messages.insert(messageModel, atIndex: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Right)
                self.tableView.endUpdates()
            }
    }
    
    override func didPressRightButton(sender: AnyObject!) {
        let messageModelToSend = MessageModel(name: name, content: self.textView.text)
        let jsonString = messageModelToSend.toJSON().rawString()!
        websocket.writeString(jsonString)
        
        
        super.didPressRightButton(sender)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(MessageTableViewCell.ReuseId, forIndexPath: indexPath) as! MessageTableViewCell
        cell.nameLabel.text = message.name
        cell.contentLabel.text = message.content
        cell.transform = tableView.transform
        return cell
    }
    
}

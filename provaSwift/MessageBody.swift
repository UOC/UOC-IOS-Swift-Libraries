//
//  MessageBody.swift
//  Open APIS
//
//  Created by UOC on 11/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class MessageBody: NSObject {
    var identifier : NSString = ""
    var body : NSString = ""
    
    func setDatos(bodyDictionary : NSDictionary){
        self.identifier = bodyDictionary.objectForKey("id") as NSString
        self.body = bodyDictionary.objectForKey("body") as NSString
    }
    
    func getClassroomsIdBoardsIdFoldersIdMessagesIdBody(idenC:NSString, BoardId idenB:NSString, FolderId idenF:NSString, MessageId idenM:NSString, withToken token:NSString) -> MessageBody{
        var mb = MessageBody()
        
        var messagebodyURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/\(idenF)/messages/\(idenM)/body?access_token=\(token)")
        
        var messagebodyData = NSData.dataWithContentsOfURL(messagebodyURL, options: nil, error: nil)
        
        if (messagebodyData != nil){
            var messagebodyDict = NSJSONSerialization.JSONObjectWithData(messagebodyData, options: nil, error: nil) as NSDictionary
            
            if (messagebodyDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdFoldersIdMessagesIdBody GET")
                return mb
            }
            mb.setDatos(messagebodyDict)
        }
        else {
            println("messagebodyData nil")
        }
        
        return mb
    }
    
    func getMailMessagesIdBody(idenM:NSString, withToken token:NSString) -> MessageBody{
        var mb = MessageBody()
        
        var messagebodyURL = NSURL(string: "\(baseUrl)mail/messages/\(idenM)/body?access_token=\(token)")
        
        var messagebodyData = NSData.dataWithContentsOfURL(messagebodyURL, options: nil, error: nil)
        
        if (messagebodyData != nil){
            var messagebodyDict = NSJSONSerialization.JSONObjectWithData(messagebodyData, options: nil, error: nil) as NSDictionary
            
            if (messagebodyDict.valueForKey("error")){
                println("error MailMessagesIdBody GET")
                return mb
            }
            mb.setDatos(messagebodyDict)
        }
        else {
            println("messagebodyData nil")
        }
        
        return mb
    }
    
    func getSubjectsIdBoardsIdFoldersIdMessagesIdBody(idenS:NSString, BoardId idenB:NSString, FolderId idenF:NSString, MessageId idenM:NSString, withToken token:NSString) -> MessageBody{
        var mb = MessageBody()
        
        var messagebodyURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders/\(idenF)/messages/\(idenM)/body?access_token=\(token)")
        
        var messagebodyData = NSData.dataWithContentsOfURL(messagebodyURL, options: nil, error: nil)
        
        if (messagebodyData != nil){
            var messagebodyDict = NSJSONSerialization.JSONObjectWithData(messagebodyData, options: nil, error: nil) as NSDictionary
            
            if (messagebodyDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdFoldersIdMessagesIdBody GET")
                return mb
            }
            mb.setDatos(messagebodyDict)
        }
        else {
            println("messagebodyData nil")
        }
        
        return mb
    }
}

//
//  MessageList.swift
//  Open APIS
//
//  Created by UOC on 11/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class MessageList: NSObject {
    var messages = NSMutableArray()
    
    func setDatos(dict : NSDictionary){
        var n = dict.objectForKey("messages").count
        var i = 0
        if(n > 0){
            var auxArray = dict.objectForKey("messages") as NSMutableArray
            while (i < n){
                var m = Message()
                m.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
                self.messages.addObject(m)
                i++
            }
        }
    }
    
    
    func getClassroomsIdBoardsIdMessages(idenC : NSString, BoardId idenB : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/messages?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdMessages GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getClassroomsIdBoardsIdMessagesUnread(idenC : NSString, BoardId idenB : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/messages/unread?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdMessagesUnread GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getClassroomsIdBoardsIdFoldersIdMessages(idenC : NSString, BoardId idenB : NSString, FolderId idenF : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/\(idenF)/messages?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdFoldersIdMessages GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getClassroomsIdBoardsIdFoldersIdMessagesUnread(idenC : NSString, BoardId idenB : NSString, FolderId idenF : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/\(idenF)/messages/unread?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdFoldersIdMessagesUnread GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getMailMessages(token : NSString) -> NSMutableArray{
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)mail/messages?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error MailMessages GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getMailMessagesUnread(token : NSString) -> NSMutableArray{
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)mail/messages/unread?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error MailMessagesUnread GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    
    func getMailFoldersIdMessages(idenF : NSString, withToken token : NSString) -> NSMutableArray{
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)mail/folders/\(idenF)/messages?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error MailFoldersIdMessages GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getMailFoldersIdMessagesUnread(idenF : NSString, withToken token : NSString) -> NSMutableArray{
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)mail/folders/\(idenF)/messages/unread?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error MailFoldersIdMessagesUnread GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    
    func getSubjectsIdBoardsIdMessages(idenS : NSString, BoardId idenB : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/messages?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdMessages GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getSubjectsIdBoardsIdMessagesUnread(idenS : NSString, BoardId idenB : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/messages/unread?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdMessagesUnread GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getSubjectsIdBoardsIdFoldersIdMessages(idenS : NSString, BoardId idenB : NSString, FolderId idenF : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders/\(idenF)/messages?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdFoldersIdMessages GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
    
    func getSubjectsIdBoardsIdFoldersIdMessagesUnread(idenS : NSString, BoardId idenB : NSString, FolderId idenF : NSString, withToken token : NSString) -> NSMutableArray{
        
        self.messages.removeAllObjects()
        
        var messagesURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders/\(idenF)/messages/unread?access_token=\(token)")
        
        var messagesData = NSData(contentsOfURL: messagesURL)
        
        if (messagesData != nil){
            var messagesDict = NSJSONSerialization.JSONObjectWithData(messagesData, options: nil, error: nil) as NSDictionary
            
            if(messagesDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdFoldersIdMessagesUnread GET")
                return self.messages
            }
            self.setDatos(messagesDict)
        }
        else {
            println("messagesData nil")
        }
        
        return self.messages
    }
}

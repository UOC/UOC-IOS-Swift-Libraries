//
//  Message.swift
//  Open APIS
//
//  Created by UOC on 11/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class Message: NSObject {
    var identifier : NSString = ""
    var subject : NSString? = ""
    var snippet : NSString? = ""
    var date : NSString? = ""
    var color : NSNumber? = 0
    var status : NSNumber? = 0
    var from : NSString? = ""
    var to : NSString? = ""
    var cc : NSString? = ""
    var body : NSString? = ""
    
    // New information ONLY for boards messages
    
    var parentMessage : NSString? = ""
    var previousMessage : NSString? = ""
    var nextMessage : NSString? = ""
    
    
    func setDatos(messageDict : NSDictionary){
        
        self.identifier = messageDict.objectForKey("id") as NSString
        self.subject = messageDict.objectForKey("subject") as? NSString
        self.snippet = messageDict.objectForKey("snippet") as? NSString
        self.date = messageDict.objectForKey("date") as? NSString
        self.color = messageDict.objectForKey("color") as? NSNumber
        self.status = messageDict.objectForKey("status") as? NSNumber
        self.from = messageDict.objectForKey("from") as? NSString
        self.to = messageDict.objectForKey("to") as? NSString
        self.cc = messageDict.objectForKey("cc") as? NSString
        self.body = messageDict.objectForKey("body") as? NSString
        
        self.parentMessage = messageDict.objectForKey("parentMessage") as? NSString
        self.previousMessage = messageDict.objectForKey("previousMessage") as? NSString
        self.nextMessage = messageDict.objectForKey("nextMessage") as? NSString
    }
    
    
    
    func getClassroomsIdBoardsIdMessageId(idenC:NSString, BoardId idenB:NSString, MessageId idenM: NSString, withToken token:NSString) -> Message{
        var m = Message()
        
        var messageURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/messages/\(idenM)?access_token=\(token)")
        
        var messageData = NSData(contentsOfURL: messageURL)
        
        if (messageData != nil){
            var messageDict = NSJSONSerialization.JSONObjectWithData(messageData, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdMessageId Get")
                return m
            }
            m.setDatos(messageDict)
        }
        else {
            println("messageData nil")
        }
        return m
    }
    
    
    func getClassroomsIdBoardsIdFoldersIdMessageId(idenC:NSString, BoardId idenB:NSString, FolderId idenF : NSString, MessageId idenM: NSString, withToken token:NSString) -> Message{
        var m = Message()
        
        var messageURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/\(idenF)/messages/\(idenM)?access_token=\(token)")
        
        var messageData = NSData(contentsOfURL: messageURL)
        
        if (messageData != nil){
            var messageDict = NSJSONSerialization.JSONObjectWithData(messageData, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdFoldersIdMessageId Get")
                return m
            }
            m.setDatos(messageDict)
        }
        else {
            println("messageData nil")
        }
        return m
    }
    
    func getMailMessageId(idenM: NSString, withToken token:NSString) -> Message{
        var m = Message()
        
        var messageURL = NSURL(string: "\(baseUrl)mail/messages/\(idenM)?access_token=\(token)")
        
        var messageData = NSData(contentsOfURL: messageURL)
        
        if (messageData != nil){
            var messageDict = NSJSONSerialization.JSONObjectWithData(messageData, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("error MailMessageId Get")
                return m
            }
            m.setDatos(messageDict)
        }
        else {
            println("messageData nil")
        }
        return m
    }
    
    func getSubjectsIdBoardsIdMessageId(idenS:NSString, BoardId idenB:NSString, MessageId idenM: NSString, withToken token:NSString) -> Message{
        var m = Message()
        
        var messageURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/messages/\(idenM)?access_token=\(token)")
        
        var messageData = NSData(contentsOfURL: messageURL)
        
        if (messageData != nil){
            var messageDict = NSJSONSerialization.JSONObjectWithData(messageData, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdMessageId Get")
                return m
            }
            m.setDatos(messageDict)
        }
        else {
            println("messageData nil")
        }
        return m
    }
    
    
    func getSubjectsIdBoardsIdFoldersIdMessageId(idenS:NSString, BoardId idenB:NSString, FolderId idenF : NSString, MessageId idenM: NSString, withToken token:NSString) -> Message{
        var m = Message()
        
        var messageURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders/\(idenF)/messages/\(idenM)?access_token=\(token)")
        
        var messageData = NSData(contentsOfURL: messageURL)
        
        if (messageData != nil){
            var messageDict = NSJSONSerialization.JSONObjectWithData(messageData, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdFoldersIdMessageId Get")
                return m
            }
            m.setDatos(messageDict)
        }
        else {
            println("messageData nil")
        }
        return m
    }
    
    
    // Problemes amb els POST
    func postClassroomsIdBoardsIdMessages(idenC : NSString, BoardId idenB : NSString, MessagePost postMessage:Message, withToken token : NSString) ->Message{
        
        var m = Message()
        
        // Falta definir el dictionary
        var nouMessage : NSDictionary = ["id":postMessage.identifier, "subject":postMessage.subject!, "snippet":postMessage.snippet!, "date":postMessage.date!, "color":postMessage.color!, "status":postMessage.status!, "from":postMessage.from!, "cc":postMessage.cc!, "body":postMessage.body!] as NSDictionary
        
        var jsonData = NSJSONSerialization.dataWithJSONObject(nouMessage, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        var messageURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/messages?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: messageURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var messageDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("Error Post ClassroomsIdBoardsIdMessages")
                return m
            }
            m.setDatos(messageDict)
        }
        return m
    }
    
    func postMailMessages(postMessage : Message, withToken token : NSString) ->Message{
        
        var m = Message()
        
        var nouMessage : NSDictionary = ["id":postMessage.identifier, "subject":postMessage.subject!, "snippet":postMessage.snippet!, "date":postMessage.date!, "color":postMessage.color!, "status":postMessage.status!, "from":postMessage.from!, "cc":postMessage.cc!, "body":postMessage.body!] as NSDictionary
        
        var jsonData = NSJSONSerialization.dataWithJSONObject(nouMessage, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        var messageURL = NSURL(string: "\(baseUrl)mail/messages?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: messageURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var messageDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("Error Post MailMessages")
                return m
            }
            m.setDatos(messageDict)
        }
        return m
    }
    
    func postSubjectsIdBoardsIdMessages(idenS : NSString, BoardId idenB : NSString, MessagePost postMessage:Message, withToken token : NSString) ->Message{
        
        var m = Message()
        
        // Falta definir previousMessage, nextMessage, parentMessage dins  del dictionary
        var nouMessage : NSDictionary = ["id":postMessage.identifier, "subject":postMessage.subject!, "snippet":postMessage.snippet!, "date":postMessage.date!, "color":postMessage.color!, "status":postMessage.status!, "from":postMessage.from!, "cc":postMessage.cc!, "body":postMessage.body!] as NSDictionary
        
        var jsonData = NSJSONSerialization.dataWithJSONObject(nouMessage, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        var messageURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/messages?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: messageURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var messageDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (messageDict.valueForKey("error")){
                println("Error Post SubjectsIdBoardsIdMessages")
                return m
            }
            m.setDatos(messageDict)
        }
        return m
    }
    
}

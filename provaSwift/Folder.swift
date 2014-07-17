//
//  Folder.swift
//  Open APIS
//
//  Created by UOC on 11/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class Folder: NSObject {
    
    var identifier : NSString = ""
    var name : NSString = ""
    var totalMessages : NSNumber?
    var unreadMessages : NSNumber?
    
    func setDatos(folderDictionary : NSDictionary){
        self.identifier = folderDictionary.objectForKey("id") as NSString
        self.name = folderDictionary.objectForKey("name") as NSString
        self.totalMessages = folderDictionary.objectForKey("totalMessages") as? NSNumber
        self.unreadMessages = folderDictionary.objectForKey("unreadMessages") as? NSNumber
    }

    func getClassroomsIdBoardsIdFoldersInbox(idenC:NSString, BoardId idenB:NSString,  withToken token:NSString) -> Folder{
        var f = Folder()
        // baseUrl + "classrooms/" + idenC + "/boards/" + idenB + "/folders/inbox?access_token=" + token
        var folderURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/inbox?access_token=\(token)")
        
        var folderData = NSData.dataWithContentsOfURL(folderURL, options: nil, error: nil)
        
        if (folderData != nil){
            var folderDict = NSJSONSerialization.JSONObjectWithData(folderData, options: nil, error: nil) as NSDictionary
            
            if(folderDict.valueForKey("error")){
                println("Error classroomsIdBoardsIdFoldersInbox get")
                return f
            }
            
            f.setDatos(folderDict)
        }
        else {
            println("folderData nil")
        }
        return f
    }
    
    
    func getClassroomsIdBoardsIdFoldersId(idenC:NSString, BoardId idenB:NSString, FolderId idenF: NSString, withToken token:NSString) -> Folder{
        var f = Folder()
        // baseUrl + "classrooms/" + idenC + "/boards/" + idenB + "/folders/inbox?access_token=" + token
        var folderURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/\(idenF)?access_token=\(token)")
        
        var folderData = NSData.dataWithContentsOfURL(folderURL, options: nil, error: nil)
        
        if (folderData != nil){
            var folderDict = NSJSONSerialization.JSONObjectWithData(folderData, options: nil, error: nil) as NSDictionary
            
            if(folderDict.valueForKey("error")){
                println("Error classroomsIdBoardsIdFoldersId get")
                return f
            }
            
            f.setDatos(folderDict)
        }
        else {
            println("folderData nil")
        }
        return f
    }
    
    func getMailFoldersInbox(token:NSString) -> Folder{
        var f = Folder()
        // baseUrl + "classrooms/" + idenC + "/boards/" + idenB + "/folders/inbox?access_token=" + token
        var folderURL = NSURL(string: "\(baseUrl)mail/folders/inbox?access_token=\(token)")
        
        var folderData = NSData.dataWithContentsOfURL(folderURL, options: nil, error: nil)
        
        if (folderData != nil){
            var folderDict = NSJSONSerialization.JSONObjectWithData(folderData, options: nil, error: nil) as NSDictionary
            
            if(folderDict.valueForKey("error")){
                println("Error mailFoldersInbox get")
                return f
            }
            
            f.setDatos(folderDict)
        }
        else {
            println("folderData nil")
        }
        return f
    }
    
    func getMailFoldersId(idenF: NSString, withToken token:NSString) -> Folder{
        var f = Folder()
        // baseUrl + "classrooms/" + idenC + "/boards/" + idenB + "/folders/inbox?access_token=" + token
        var folderURL = NSURL(string: "\(baseUrl)mail/folders/\(idenF)?access_token=\(token)")
        
        var folderData = NSData.dataWithContentsOfURL(folderURL, options: nil, error: nil)
        
        if (folderData != nil){
            var folderDict = NSJSONSerialization.JSONObjectWithData(folderData, options: nil, error: nil) as NSDictionary
            
            if(folderDict.valueForKey("error")){
                println("Error mailFoldersId get")
                return f
            }
            
            f.setDatos(folderDict)
        }
        else {
            println("folderData nil")
        }
        return f
    }
    
    func getSubjectsIdBoardsIdFoldersInbox(idenS:NSString, BoardId idenB:NSString,  withToken token:NSString) -> Folder{
        var f = Folder()
        // baseUrl + "classrooms/" + idenC + "/boards/" + idenB + "/folders/inbox?access_token=" + token
        var folderURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders/inbox?access_token=\(token)")
        
        var folderData = NSData.dataWithContentsOfURL(folderURL, options: nil, error: nil)
        
        if (folderData != nil){
            var folderDict = NSJSONSerialization.JSONObjectWithData(folderData, options: nil, error: nil) as NSDictionary
            
            if(folderDict.valueForKey("error")){
                println("Error subjectsIdBoardsIdFoldersInbox get")
                return f
            }
            
            f.setDatos(folderDict)
        }
        else {
            println("folderData nil")
        }
        return f
    }
    
    
    func getSubjectsIdBoardsIdFoldersId(idenS:NSString, BoardId idenB:NSString, FolderId idenF: NSString, withToken token:NSString) -> Folder{
        var f = Folder()
        // baseUrl + "classrooms/" + idenC + "/boards/" + idenB + "/folders/inbox?access_token=" + token
        var folderURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders/\(idenF)?access_token=\(token)")
        
        var folderData = NSData.dataWithContentsOfURL(folderURL, options: nil, error: nil)
        
        if (folderData != nil){
            var folderDict = NSJSONSerialization.JSONObjectWithData(folderData, options: nil, error: nil) as NSDictionary
            
            if(folderDict.valueForKey("error")){
                println("Error subjectsIdBoardsIdFoldersId get")
                return f
            }
            
            f.setDatos(folderDict)
        }
        else {
            println("folderData nil")
        }
        return f
    }
    
    func postClassroomsIdBoardsIdMessagesIdMoveId(idenC : NSString, BoardId idenB : NSString, MessageId idenM : NSString, Destination idenDest : NSString, withToken token : NSString) -> Folder{
        
        var f = Folder()
        
        var moveURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/messages/\(idenM)/move/\(idenDest)?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: moveURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var folderDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (folderDict.valueForKey("error")){
                println("Error Post ClassroomsIdBoardsIdMessagesIdMoveId")
                return f
            }
            f.setDatos(folderDict)
        }
        
        return f
    }
    
    func postClassroomsIdBoardsIdFoldersIdMessagesIdMoveId(idenC : NSString, BoardId idenB : NSString, FolderId idenF : NSString, MessageId idenM : NSString, Destination idenDest : NSString, withToken token : NSString) -> Folder{
        
        var f = Folder()
        
        var moveURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/\(idenF)/messages/\(idenM)/move/\(idenDest)?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: moveURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var folderDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (folderDict.valueForKey("error")){
                println("Error Post ClassroomsIdBoardsIdFoldersIdMessagesIdMoveId")
                return f
            }
            f.setDatos(folderDict)
        }
        
        return f
    }
    
    func postMailFolders(postFolder : Folder, withToken token : NSString) -> Folder{
        var f = Folder()
        
        var nouFolder : NSDictionary = ["id":postFolder.identifier, "name":postFolder.name, "unreadMessages":postFolder.unreadMessages!, "totalMessages":postFolder.totalMessages!] as NSDictionary
        
        var jsonData = NSJSONSerialization.dataWithJSONObject(nouFolder, options: NSJSONWritingOptions.PrettyPrinted, error: nil) as NSData
        
        var folderURL = NSURL(string: "\(baseUrl)mail/folders?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: folderURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var folderDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (folderDict.valueForKey("error")){
                println("Error Post MailFolders")
                return f
            }
            f.setDatos(folderDict)
        }

        return f
    }
    
    
    
    func postMailMessagesIdMoveId(idenM : NSString, Destination idenDest : NSString, withToken token : NSString) -> Folder{
        
        var f = Folder()
        
        var moveURL = NSURL(string: "\(baseUrl)mail/messages/\(idenM)/move/\(idenDest)?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: moveURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var folderDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (folderDict.valueForKey("error")){
                println("Error Post MailMessagesIdMoveId")
                return f
            }
            f.setDatos(folderDict)
        }
        
        return f
    }
    
    
    func postMailFoldersIdMessagesIdMoveId(idenF:NSString, MessageId idenM : NSString, Destination idenDest : NSString, withToken token : NSString) -> Folder{
        
        var f = Folder()
        
        var moveURL = NSURL(string: "\(baseUrl)mail/\(idenF)/messages/\(idenM)/move/\(idenDest)?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: moveURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var folderDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (folderDict.valueForKey("error")){
                println("Error Post MailFoldersIdMessagesIdMoveId")
                return f
            }
            f.setDatos(folderDict)
        }
        
        return f
    }
    
    func postSubjectsIdBoardsIdMessagesIdMoveId(idenS : NSString, BoardId idenB : NSString, MessageId idenM : NSString, Destination idenDest : NSString, withToken token : NSString) -> Folder{
        
        var f = Folder()
        
        var moveURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/messages/\(idenM)/move/\(idenDest)?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: moveURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var folderDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (folderDict.valueForKey("error")){
                println("Error Post SubjectsIdBoardsIdMessagesIdMoveId")
                return f
            }
            f.setDatos(folderDict)
        }
        
        return f
    }
    
    func postSubjectsIdBoardsIdFoldersIdMessagesIdMoveId(idenS : NSString, BoardId idenB : NSString, FolderId idenF : NSString, MessageId idenM : NSString, Destination idenDest : NSString, withToken token : NSString) -> Folder{
        
        var f = Folder()
        
        var moveURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders/\(idenF)/messages/\(idenM)/move/\(idenDest)?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: moveURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var folderDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (folderDict.valueForKey("error")){
                println("Error Post SubjectsIdBoardsIdFoldersIdMessagesIdMoveId")
                return f
            }
            f.setDatos(folderDict)
        }
        
        return f
    }

}
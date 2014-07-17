//
//  Board.swift
//  Open APIS swift
//
//  Created by UOC on 02/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class Board: NSObject {
    var identifier : NSString = ""
    var subtype : NSString = ""
    var title : NSString = ""
    var code : NSString = ""
    var domainId : NSString = ""
    var unreadMessages : NSNumber?
    var totalMessages : NSNumber?
    
    func setDatos(boardDictionary : NSDictionary){
        self.identifier = boardDictionary.objectForKey("id") as NSString
        self.subtype = boardDictionary.objectForKey("subtype") as NSString
        self.title = boardDictionary.objectForKey("title") as NSString
        self.code = boardDictionary.objectForKey("code") as NSString
        self.domainId = boardDictionary.objectForKey("domainId") as NSString
        self.unreadMessages = boardDictionary.objectForKey("unreadMessages") as? NSNumber
        self.totalMessages = boardDictionary.objectForKey("totalMessages") as? NSNumber
    }
    
    func getClassroomsIdBoardsId(idenC: NSString, BoardId idenB : NSString, withToken token:NSString) -> Board{
        var b = Board()
        
        var boardURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)?access_token=\(token)")
        
        var boardData = NSData.dataWithContentsOfURL(boardURL, options: nil, error: nil)
        
        if (boardData != nil){
            var boardDict = NSJSONSerialization.JSONObjectWithData(boardData, options: nil, error: nil) as NSDictionary
            
            if(boardDict.valueForKey("error")){
                println("Error getClassroomsIdBoardsId")
                return b
            }
            b.setDatos(boardDict)
        }
        
        return b
    }
    
    func getSubjectsIdBoardsId(idenS: NSString, BoardId idenB : NSString, withToken token:NSString) -> Board{
        var b = Board()
        
        var boardURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)?access_token=\(token)")
        
        var boardData = NSData.dataWithContentsOfURL(boardURL, options: nil, error: nil)
        
        if (boardData != nil){
            var boardDict = NSJSONSerialization.JSONObjectWithData(boardData, options: nil, error: nil) as NSDictionary
            
            if(boardDict.valueForKey("error")){
                println("Error getSubjectsIdBoardsId")
                return b
            }
            b.setDatos(boardDict)
        }
        
        return b
    }
    
    
}

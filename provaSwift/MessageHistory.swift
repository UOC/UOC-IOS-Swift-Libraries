//
//  MessageHistory.swift
//  Open APIS
//
//  Created by UOC on 10/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class MessageHistory: NSObject {
    var details = NSMutableArray()
    var identifier : NSString = ""
    
    func setDatos(historyDict : NSDictionary){
        self.details.removeAllObjects()
        self.identifier = historyDict.objectForKey("id") as NSString
        var n = historyDict.objectForKey("details").count
        var i = 0
        var auxArray = historyDict.objectForKey("details") as NSMutableArray
        while (i < n){
            var mhd = MessageHistoryDetail()
            mhd.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.details.addObject(mhd)
            i++
        }
    }
    
    func getClassroomsIdBoardsIdFoldersIdMessagesIdHistory(idenC : NSString, BoardId idenB : NSString, FolderId idenF : NSString, MessageId idenM : NSString, withToken token: NSString)->MessageHistory{
        
        var mh = MessageHistory()
        
        var messageHistoryURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders/\(idenF)/messages/\(idenM)/history?access_token=\(token)")
        
        var messageHistoryData = NSData.dataWithContentsOfURL(messageHistoryURL, options: nil, error: nil)
        
        if (messageHistoryData != nil){
            var messageHistoryDict = NSJSONSerialization.JSONObjectWithData(messageHistoryData, options: nil, error: nil) as NSDictionary
            if(messageHistoryData.valueForKey("error")){
                println("error ClassroomsIdBoardsIdFoldersIdMessagesIdHistory get")
                return mh
            }
            mh.setDatos(messageHistoryDict)
            
        }
        else {
            println("messageHistoryData nil")
        }
        
        
        return mh
    }
}

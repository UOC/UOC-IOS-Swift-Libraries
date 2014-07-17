//
//  FolderList.swift
//  Open APIS
//
//  Created by UOC on 11/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class FolderList: NSObject {
    var folders = NSMutableArray()
    
    func setDatos(dict : NSDictionary){
        var n = dict.objectForKey("folders").count
        var i = 0
        if(n > 0){
            var auxArray = dict.objectForKey("folders") as NSMutableArray
            while (i < n){
                var f = Folder()
                f.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
                self.folders.addObject(f)
                i++
            }
        }
    }
    
    
    func getClassroomsIdBoardsIdFolders(idenC : NSString, BoardId idenB : NSString, withToken token : NSString) -> NSMutableArray{
        self.folders.removeAllObjects()
        
        var foldersURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/boards/\(idenB)/folders?access_token=\(token)")
        
        var foldersData = NSData(contentsOfURL: foldersURL)
        
        if (foldersData != nil){
            var foldersDict = NSJSONSerialization.JSONObjectWithData(foldersData, options: nil, error: nil) as NSDictionary
            
            if(foldersDict.valueForKey("error")){
                println("error ClassroomsIdBoardsIdFolders Get")
                return self.folders
            }
            self.setDatos(foldersDict)
        }
        else {
            println("foldersData nil")
        }
        return self.folders
    }
    
    func getMailFolders(token : NSString) -> NSMutableArray{
        self.folders.removeAllObjects()
        
        var foldersURL = NSURL(string: "\(baseUrl)mail/folders?access_token=\(token)")
        
        var foldersData = NSData(contentsOfURL: foldersURL)
        
        if (foldersData != nil){
            var foldersDict = NSJSONSerialization.JSONObjectWithData(foldersData, options: nil, error: nil) as NSDictionary
            
            if(foldersDict.valueForKey("error")){
                println("error MailFolders Get")
                return self.folders
            }
            self.setDatos(foldersDict)
        }
        else {
            println("foldersData nil")
        }
        return self.folders
    }
    
    
    func getSubjectsIdBoardsIdFolders(idenS : NSString, BoardId idenB : NSString, withToken token : NSString) -> NSMutableArray{
        self.folders.removeAllObjects()
        
        var foldersURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/boards/\(idenB)/folders?access_token=\(token)")
        
        var foldersData = NSData(contentsOfURL: foldersURL)
        
        if (foldersData != nil){
            var foldersDict = NSJSONSerialization.JSONObjectWithData(foldersData, options: nil, error: nil) as NSDictionary
            
            if(foldersDict.valueForKey("error")){
                println("error SubjectsIdBoardsIdFolders Get")
                return self.folders
            }
            self.setDatos(foldersDict)
        }
        else {
            println("foldersData nil")
        }
        return self.folders
    }

}

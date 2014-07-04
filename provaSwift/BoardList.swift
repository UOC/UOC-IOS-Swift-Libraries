//
//  BoardList.swift
//  Open APIS swift
//
//  Created by UOC on 02/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class BoardList: NSObject {
    var boards = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("boards").count
        var i = 0
        var auxArray = dict.objectForKey("boards") as NSMutableArray
        while (i < n){
            var b = Board()
            b.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.boards.addObject(b)
            i++
        }
    }
    
    func getClassroomsIdBoards(idenC:NSString, withToken token:NSString) -> NSMutableArray{
        self.boards.removeAllObjects()
        
        var boardsURL = NSURL(string: baseUrl + "classrooms/" + idenC + "/boards?access_token=" + token)
        
        var boardsData = NSData.dataWithContentsOfURL(boardsURL, options: nil, error: nil)
        
        if (boardsData != nil){
            var boardsDict = NSJSONSerialization.JSONObjectWithData(boardsData, options: nil, error: nil) as NSDictionary
            
            if (boardsDict.valueForKey("error") != nil){
                println("Error en ClassroomsIdBoards GET")
                return self.boards
            }
            self.setDatos(boardsDict)
        }
        
        return self.boards
    }
    
    func getSubjectsIdBoards(idenS:NSString, withToken token:NSString) -> NSMutableArray{
        self.boards.removeAllObjects()
        
        var boardsURL = NSURL(string: baseUrl + "subjects/" + idenS + "/boards?access_token=" + token)
        
        var boardsData = NSData.dataWithContentsOfURL(boardsURL, options: nil, error: nil)
        
        if (boardsData != nil){
            var boardsDict = NSJSONSerialization.JSONObjectWithData(boardsData, options: nil, error: nil) as NSDictionary
            
            if (boardsDict.valueForKey("error") != nil){
                println("Error en SubjectsIdBoards GET")
                return self.boards
            }
            self.setDatos(boardsDict)
        }
        
        return self.boards
    }
}

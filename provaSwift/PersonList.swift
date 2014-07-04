//
//  PersonList.swift
//  Open APIS swift
//
//  Created by UOC on 03/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class PersonList: NSObject {
    var people = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("people").count
        var i = 0
        var auxArray = dict.objectForKey("people") as NSMutableArray
        while (i < n){
            var p = Person()
            p.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.people.addObject(p)
            i++
        }
    }
    
    func getPeople(token: NSString) -> NSMutableArray{
        self.people.removeAllObjects()
        
        var peopleURL = NSURL(string: baseUrl + "people?access_token=" + token)
        
        var peopleData = NSData.dataWithContentsOfURL(peopleURL, options: nil, error: nil)
        
        if(peopleData != nil){
            var peopleDict = NSJSONSerialization.JSONObjectWithData(peopleData, options: nil, error: nil) as NSDictionary
            
            if(peopleDict.valueForKey("error") != nil){
                println("error people GET")
                return self.people
            }
            self.setDatos(peopleDict)
        }
        
        return self.people
    }
}

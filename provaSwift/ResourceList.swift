//
//  ResourceList.swift
//  Open APIS
//
//  Created by UOC on 11/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class ResourceList: NSObject {
    var resources = NSMutableArray()
    
    func setDatos(dict : NSDictionary){
        self.resources.removeAllObjects()
        var n = dict.objectForKey("resources").count
        var i = 0
        if(n > 0){
            var auxArray = dict.objectForKey("resources") as NSMutableArray
            while (i < n){
                var r = Resource()
                r.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
                self.resources.addObject(r)
                i++
            }
        }
    }
    
    func getClassroomsIdResources(idenC:NSString, withToken token:NSString) -> NSMutableArray{
        self.resources.removeAllObjects()
        
        var resourcesURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/resources?access_token=\(token)")
        
        var resourcesData = NSData.dataWithContentsOfURL(resourcesURL, options: nil, error: nil)
        
        if (resourcesData != nil){
            var resourcesDict = NSJSONSerialization.JSONObjectWithData(resourcesData, options: nil, error: nil) as NSDictionary
            if (resourcesDict.valueForKey("error")){
                println("error ClassroomsIdResources GET")
                return self.resources
            }
            self.setDatos(resourcesDict)
        }
        else {
            println("resourcesData nil")
        }
        
        return self.resources
    }
    
    func getSubjectsIdResources(idenS:NSString, withToken token:NSString) -> NSMutableArray{
        self.resources.removeAllObjects()
        
        var resourcesURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/resources?access_token=\(token)")

        var resourcesData = NSData.dataWithContentsOfURL(resourcesURL, options: nil, error: nil)
        
        if (resourcesData != nil){
            var resourcesDict = NSJSONSerialization.JSONObjectWithData(resourcesData, options: nil, error: nil) as NSDictionary
            if (resourcesDict.valueForKey("error")){
                println("error SubjectsIdResources GET")
                return self.resources
            }
            self.setDatos(resourcesDict)
        }
        else {
            println("resourcesData nil")
        }
        
        return self.resources
    }
    
}

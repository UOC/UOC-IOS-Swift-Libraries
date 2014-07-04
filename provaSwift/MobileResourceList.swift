//
//  MobileResourceList.swift
//  Open APIS swift
//
//  Created by UOC on 19/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class MobileResourceList: NSObject {
    var mobileResources = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("mobileResources").count
        var i = 0
        var auxArray = dict.objectForKey("mobileResources") as NSMutableArray
        while (i < n){
            var r = MobileResource()
            r.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.mobileResources.addObject(r)
            i++
        }
    }
    
    func getMobileResources(token: NSString) -> NSMutableArray{
        self.mobileResources.removeAllObjects()
        
        var resourceURL = NSURL(string: baseUrl + "mobileresources?access_token=" + token)
        
        var resourceData = NSData.dataWithContentsOfURL(resourceURL, options: nil, error: nil)
        
        if (resourceData != nil){
            var resourceDict = NSJSONSerialization.JSONObjectWithData(resourceData, options: nil, error: nil) as NSDictionary
            if (resourceDict.valueForKey("error") != nil){
                println("Error en resources Get")
                return self.mobileResources
            }
            println(resourceDict.description)
            self.setDatos(resourceDict)
        }
        
        
        return self.mobileResources
    }
}

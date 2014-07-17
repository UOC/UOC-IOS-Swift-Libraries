//
//  MobileResource.swift
//  Open APIS swift
//
//  Created by UOC on 19/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class MobileResource: NSObject {
    var ident : NSString = ""
    var type : NSString = ""
    var urlIOS : NSString = ""
    var urlMarketIOS : NSString = ""
    var nameIOS : NSString = ""
    var logoIOS : NSString = ""
    var descriptionIOS : NSString = ""
    
    func setDatos(mobileResourcesDictionary: NSDictionary){
        ident = mobileResourcesDictionary.objectForKey("id") as NSString
        type = mobileResourcesDictionary.objectForKey("type") as NSString
        urlIOS = mobileResourcesDictionary.objectForKey("urlIOS") as NSString
        urlMarketIOS = mobileResourcesDictionary.objectForKey("urlMarketIOS") as NSString
        nameIOS = mobileResourcesDictionary.objectForKey("nameIOS") as NSString
        logoIOS = mobileResourcesDictionary.objectForKey("logoIOS") as NSString
        descriptionIOS = mobileResourcesDictionary.objectForKey("descriptionIOS") as NSString
    }
    
    func getMobileResourcesId(idenR: NSString, withToken token: NSString) -> MobileResource{
        var r = MobileResource()
        
        var resourceURL = NSURL(string: baseUrl + "mobileresources/" + idenR + "?access_token=" + token)
        
        var resourceData = NSData.dataWithContentsOfURL(resourceURL, options: nil, error: nil)
        
        if (resourceData != nil){
            var resourceDict = NSJSONSerialization.JSONObjectWithData(resourceData, options: nil, error: nil) as NSDictionary
            if (resourceDict.valueForKey("error")){
                println("Error en resource_id Get")
                return r
            }
            println(resourceDict.description)
            r.setDatos(resourceDict)
        }
        return r
    }
    
    func getMobileResourcesByType(type: NSString, withToken token: NSString) -> MobileResource{
        var r = MobileResource()

        var resourceURL = NSURL(string: baseUrl + "mobileresources/bytype/" + type + "?access_token=" + token)
        
        var resourceData = NSData.dataWithContentsOfURL(resourceURL, options: nil, error: nil)
        
        if (resourceData != nil){
            var resourceDict = NSJSONSerialization.JSONObjectWithData(resourceData, options: nil, error: nil) as NSDictionary
            if (resourceDict.valueForKey("error")){
                println("Error en resource_bytype Get")
                return r
            }
            println(resourceDict.description)
            r.setDatos(resourceDict)
        }
        return r
    }
}

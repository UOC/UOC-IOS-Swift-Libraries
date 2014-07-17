//
//  Resource.swift
//  Open APIS
//
//  Created by UOC on 11/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class Resource: NSObject {
    var identifier : NSString = ""
    var type : NSString = ""
    var subtype : NSString = ""
    var title : NSString = ""
    var code : NSString = ""
    var domainId : NSString = ""
    
    func setDatos(resourceDictionary : NSDictionary){
        self.identifier = resourceDictionary.objectForKey("id") as NSString
        self.type = resourceDictionary.objectForKey("type") as NSString
        self.subtype = resourceDictionary.objectForKey("subtype") as NSString
        self.title = resourceDictionary.objectForKey("title") as NSString
        self.code = resourceDictionary.objectForKey("code") as NSString
        self.domainId = resourceDictionary.objectForKey("domainId") as NSString
    }
    
    func getClassroomsIdResourcesId(idenC:NSString, ResourceId idenR:NSString, withToken token:NSString) -> Resource{
        var r = Resource()
        
        var resourceURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/resources/\(idenR)?access_token=\(token)")
        
        var resourceData = NSData.dataWithContentsOfURL(resourceURL, options: nil, error: nil)
        
        if (resourceData != nil){
            var resourceDict = NSJSONSerialization.JSONObjectWithData(resourceData, options: nil, error: nil) as NSDictionary
            
            if(resourceDict.valueForKey("error")){
                println("error en ClassroomsIdResourcesId GET")
                return r
            }
            r.setDatos(resourceDict)
        }
        else{
            println("resourceData nil")
        }
        
        return r
    }
    
    func getSubjectsIdResourcesId(idenS:NSString, ResourceId idenR:NSString, withToken token:NSString) -> Resource{
        var r = Resource()
        
        var resourceURL = NSURL(string: "\(baseUrl)subjects/\(idenS)/resources/\(idenR)?access_token=\(token)")
        
        var resourceData = NSData.dataWithContentsOfURL(resourceURL, options: nil, error: nil)
        
        if (resourceData != nil){
            var resourceDict = NSJSONSerialization.JSONObjectWithData(resourceData, options: nil, error: nil) as NSDictionary
            
            if(resourceDict.valueForKey("error")){
                println("error en SubjectsIdResourcesId GET")
                return r
            }
            r.setDatos(resourceDict)
        }
        else{
            println("resourceData nil")
        }
        
        return r
    }
    
    func postClassroomsIdResources(idenC:NSString, resource postResource:Resource, withToken token:NSString) -> Resource{
        var r = Resource()
        
        var nouResource = ["id":postResource.identifier,"type":postResource.type,"subtype":postResource.subtype,"title":postResource.title,"code":postResource.code,"domainId":postResource.domainId] as NSDictionary
        var jsonData = NSJSONSerialization.dataWithJSONObject(nouResource, options: NSJSONWritingOptions.PrettyPrinted, error: nil) as NSData
        
        var resourceURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/resources?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: resourceURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var resourceDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if(resourceDict.valueForKey("error")){
                println("error ClassroomsIdResources POST")
                return r
            }
            r.setDatos(resourceDict)
            
        }
        else {
            println("postData nil")
        }

        
        return r
    }
}

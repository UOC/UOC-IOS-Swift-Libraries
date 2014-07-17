//
//  TeachingMaterial.swift
//  Open APIS swift
//
//  Created by UOC on 26/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class TeachingMaterial: NSObject {
   
    var identifier : NSString = ""
    var type : NSString? = ""// Tots els valors que puguin ser null s'indiquen aixi
    var title : NSString = ""
    var url : NSString = ""
    
    func setDatos(materialDictionary : NSDictionary){
        println(materialDictionary.description)
        identifier = materialDictionary.objectForKey("id") as NSString
        type = materialDictionary.objectForKey("type") as? NSString
        title = materialDictionary.objectForKey("title") as NSString
        url = materialDictionary.objectForKey("url") as NSString
    }
    
    func getClassroomsIdMaterialsId(idenC: NSString, MaterialId idenM: NSString, withToken token: NSString) ->TeachingMaterial{
        var m = TeachingMaterial()
        
        var materialURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/materials/\(idenM)?access_token=\(token)")
        
        var materialData = NSData.dataWithContentsOfURL(materialURL, options: nil, error: nil)
        
        if (materialData != nil){
            var materialDict = NSJSONSerialization.JSONObjectWithData(materialData, options: nil, error: nil) as NSDictionary
            
            if (materialDict.valueForKey("error")){
                println("Error Classrooms ID Materials ID Get")
                return m
            }
            m.setDatos(materialDict)
            
        }
        
        return m
    }
    
    func postClassroomIdMaterials(idenC: NSString, material postMaterial:TeachingMaterial, withToken token:NSString) -> TeachingMaterial{
        var m = TeachingMaterial()
        
        var nouMaterial : NSDictionary = ["id":postMaterial.identifier,"type":postMaterial.type,"title":postMaterial.title,"url":postMaterial.url]
        
        var jsonData = NSJSONSerialization.dataWithJSONObject(nouMaterial, options: NSJSONWritingOptions.PrettyPrinted, error: nil) as NSData
        
        var materialsURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/materials?access_token=\(token)")
        
        var request = NSMutableURLRequest(URL: materialsURL)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if (data != nil){
            var materialsDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (materialsDict.valueForKey("error")){
                println("Error Post Calendar Events")
                return m
            }
            m.setDatos(materialsDict)
        }
        
        return m
    }
}

//
//  TeachingMaterialList.swift
//  Open APIS swift
//
//  Created by UOC on 26/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class TeachingMaterialList: NSObject {
    var materials = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("materials").count
        var i = 0
        var auxArray = dict.objectForKey("materials") as NSMutableArray
        while (i < n){
            var m = TeachingMaterial()
            m.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.materials.addObject(m)
            i++
        }
    }
    
    
    func getClassroomsIdMaterials(idenC: NSString, withToken token: NSString) -> NSMutableArray{
        self.materials.removeAllObjects()
        
        var materialsURL = NSURL(string: baseUrl + "classrooms/" + idenC + "/materials?access_token=" + token)
        
        var materialsData = NSData.dataWithContentsOfURL(materialsURL, options: nil, error: nil)
        
        if (materialsData != nil){
            var materialsDict = NSJSONSerialization.JSONObjectWithData(materialsData, options: nil, error: nil) as NSDictionary
            println(materialsDict.description)
            if (materialsDict.valueForKey("error") != nil){
                println("Error en Classrooms Id Materials Get")
                return self.materials
            }
            self.setDatos(materialsDict)
        }
        
        return self.materials
    }
}

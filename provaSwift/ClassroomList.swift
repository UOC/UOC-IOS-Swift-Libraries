//
//  ClassroomList.swift
//  Open APIS swift
//
//  Created by UOC on 27/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class ClassroomList: NSObject {
    var classrooms = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("classrooms").count
        var i = 0
        var auxArray = dict.objectForKey("classrooms") as NSMutableArray
        while (i < n){
            var c = Classroom()
            c.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.classrooms.addObject(c)
            i++
        }
    }
    
    func getClassrooms(token : NSString) -> NSMutableArray{
        self.classrooms.removeAllObjects()
        
        var classroomsURL = NSURL(string: "\(baseUrl)classrooms?access_token=\(token)")
        
        var classroomsData = NSData.dataWithContentsOfURL(classroomsURL, options: nil, error: nil)
        
        if (classroomsData != nil){
            
            var classroomsDict = NSJSONSerialization.JSONObjectWithData(classroomsData, options: nil, error: nil) as NSDictionary
            println(classroomsDict.description)

            if(classroomsDict.valueForKey("error")){
                println("Error Classrooms Get")
                return self.classrooms
            }
            
            self.setDatos(classroomsDict)
        }
        
        else {
            println("Classrooms nil")
        }
        
        return self.classrooms
    }
}

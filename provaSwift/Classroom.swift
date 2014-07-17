//
//  Classroom.swift
//  Open APIS swift
//
//  Created by UOC on 26/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class Classroom: NSObject {
    
    var identifier : NSString = ""
    var title : NSString = ""
    var color : NSString = ""
    var fatherId : NSString = ""
    var assignments = NSMutableArray()
    var code : NSString = ""
    var shortTitle : NSString = ""
    var coursePlans = NSMutableArray()
    var planCode : NSString?
    
    func setDatos(dict : NSDictionary){
        self.identifier = dict.objectForKey("id") as NSString
        self.title = dict.objectForKey("title") as NSString
        self.color = dict.objectForKey("color") as NSString
        self.fatherId = dict.objectForKey("fatherId") as NSString
        self.assignments = dict.objectForKey("assignments") as NSMutableArray
        self.code = dict.objectForKey("code") as NSString
        self.shortTitle = dict.objectForKey("shortTitle") as NSString
        self.planCode = dict.objectForKey("planCode") as? NSString
        var n = dict.objectForKey("coursePlans").count
        var i = 0
        var auxArray = dict.objectForKey("coursePlans") as NSMutableArray
        while (i < n){
            var cp = CoursePlan()
            cp.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.coursePlans.addObject(cp)
            i++
        }
    }
    
    func getClassroomsId(iden: NSString, withToken token:NSString) -> Classroom{
        
        var c = Classroom()
        
        var classroomURL = NSURL(string: "\(baseUrl)classrooms/\(iden)?access_token=\(token)")
        
        var classroomData = NSData.dataWithContentsOfURL(classroomURL, options: nil, error: nil)
        
        if (classroomData != nil){
            var classroomDict = NSJSONSerialization.JSONObjectWithData(classroomData, options: nil, error: nil) as NSDictionary
            println(classroomDict.description)
            if (classroomDict.valueForKey("error")){
                println("Error en Classrooms Id Get")
                return c
            }
            c.setDatos(classroomDict)
            
        }
        return c
    }
    
}

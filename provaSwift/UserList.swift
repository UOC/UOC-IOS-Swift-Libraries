//
//  UserList.swift
//  Open APIS swift
//
//  Created by UOC on 26/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class UserList: NSObject {
    var users = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("users").count
        var i = 0
        var auxArray = dict.objectForKey("users") as NSMutableArray
        while (i < n){
            var u = User()
            u.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.users.addObject(u)
            i++
        }
    }
    
    func getClassroomsIdPeople(idenC: NSString, withToken token:NSString) -> NSMutableArray{
        self.users.removeAllObjects()
        
        var usersURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/people?access_token=\(token)")
        
        var usersData = NSData.dataWithContentsOfURL(usersURL, options: nil, error: nil)
        
        if (usersData != nil){
            var usersDict = NSJSONSerialization.JSONObjectWithData(usersData, options: nil, error: nil) as NSDictionary
            
            if (usersDict.valueForKey("error")){
                println("Error en Classrooms Id People Get")
                return self.users
            }
            setDatos(usersDict)
        }
        
        return self.users
    }

    func getClassroomsIdPeopleStudents(idenC: NSString, withToken token:NSString) -> NSMutableArray{
        self.users.removeAllObjects()
        
        var usersURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/people/students?access_token=\(token)")
        
        var usersData = NSData.dataWithContentsOfURL(usersURL, options: nil, error: nil)
        
        if (usersData != nil){
            var usersDict = NSJSONSerialization.JSONObjectWithData(usersData, options: nil, error: nil) as NSDictionary
            
            if (usersDict.valueForKey("error")){
                println("Error en Classrooms Id People_Students Get")
                return self.users
            }
            setDatos(usersDict)
        }
        
        return self.users
    }
    
    func getClassroomsIdPeopleTeachers(idenC: NSString, withToken token:NSString) -> NSMutableArray{
        self.users.removeAllObjects()
        
        var usersURL = NSURL(string: "\(baseUrl)classrooms/\(idenC)/people/teachers?access_token=\(token)")
        
        var usersData = NSData.dataWithContentsOfURL(usersURL, options: nil, error: nil)
        
        if (usersData != nil){
            var usersDict = NSJSONSerialization.JSONObjectWithData(usersData, options: nil, error: nil) as NSDictionary
            
            if (usersDict.valueForKey("error")){
                println("Error en Classrooms Id People_Teachers Get")
                return self.users
            }
            setDatos(usersDict)
        }
        
        return self.users
    }
    
    func getPeopleIdTutors(idenP: NSString, withToken token:NSString) -> NSMutableArray{
        self.users.removeAllObjects()
        
        var usersURL = NSURL(string: baseUrl + "people/" + idenP + "/tutors?access_token=" + token)
        
        var usersData = NSData.dataWithContentsOfURL(usersURL, options: nil, error: nil)
        
        if (usersData != nil){
            var usersDict = NSJSONSerialization.JSONObjectWithData(usersData, options: nil, error: nil) as NSDictionary
            
            if (usersDict.valueForKey("error")){
                println("Error en People Id Tutors Get")
                return self.users
            }
            setDatos(usersDict)
        }
        
        return self.users
    }
    
    func getUserTutors(token:NSString) -> NSMutableArray{
        self.users.removeAllObjects()
        
        var usersURL = NSURL(string: baseUrl + "user/tutors?access_token=" + token)
        
        var usersData = NSData.dataWithContentsOfURL(usersURL, options: nil, error: nil)
        
        if (usersData != nil){
            var usersDict = NSJSONSerialization.JSONObjectWithData(usersData, options: nil, error: nil) as NSDictionary
            
            if (usersDict.valueForKey("error")){
                println("Error en User Tutors Get")
                return self.users
            }
            setDatos(usersDict)
        }
        
        return self.users
    }
}

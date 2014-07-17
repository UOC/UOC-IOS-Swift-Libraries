//
//  User.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 10/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class User: NSObject {
    var identifier : NSString = ""
    var username   : NSString = ""
    var name       : NSString = ""
    var number     : NSString = ""
    var fullname   : NSString = ""
    var language   : NSString = ""
    var sessionID  : NSString = ""
    var email      : NSString = ""
    var photoUrl   : NSString = ""
    var photo      : UIImage  = UIImage()
    
    func setDatos(userDictionary: NSDictionary){
        identifier = userDictionary.objectForKey("id") as NSString
        username = userDictionary.objectForKey("username") as NSString
        name = userDictionary.objectForKey("name") as NSString
        number = userDictionary.objectForKey("number") as NSString
        fullname = userDictionary.objectForKey("fullName") as NSString
        language = userDictionary.objectForKey("language") as NSString
        sessionID = userDictionary.objectForKey("sessionId") as NSString
        email = userDictionary.objectForKey("email") as NSString
        photoUrl = userDictionary.objectForKey("photoUrl") as NSString
        var photoData = NSData.dataWithContentsOfURL(NSURL(string: photoUrl), options: nil, error: nil)
        photo = UIImage(data: photoData)
    }
    
    func getUser(token: NSString) -> User{
        var u : User = User()
        
        var userURL = NSURL(string: baseUrl+"user?access_token="+token)
        
        println("userUrl - " + userURL.description)
        
        var userData = NSData.dataWithContentsOfURL(userURL, options: nil, error: nil)
        
        if (userData != nil){
            var userDict = NSJSONSerialization.JSONObjectWithData(userData, options: nil, error: nil) as NSDictionary
            if (userDict.valueForKey("error")){
                println("Error en user Get")
                return u
            }
            println(userDict.description)
            u.setDatos(userDict)
        }
        else {
            println("User nil")
        }
        
        return u
    }
    
}

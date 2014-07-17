//
//  Profile.swift
//  Open APIS
//
//  Created by UOC on 04/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit
import Foundation

class Profile: NSObject {
    var appId : NSString = ""
    var app : NSString = ""
    var identifier : NSString = ""
    var userSubtypeId : NSString = ""
    var userType : NSString = ""
    var usertypeId : NSString = ""
    var userSubtype : NSString = ""
    var language : NSString = ""
    
    func setDatos(profileDictionary : NSDictionary){
        self.appId = profileDictionary.objectForKey("appId") as NSString
        self.app = profileDictionary.objectForKey("app") as NSString
        self.identifier = profileDictionary.objectForKey("id") as NSString
        self.userSubtypeId = profileDictionary.objectForKey("userSubtypeId") as NSString
        self.userType = profileDictionary.objectForKey("userType") as NSString
        self.usertypeId = profileDictionary.objectForKey("usertypeId") as NSString
        self.userSubtype = profileDictionary.objectForKey("userSubtype") as NSString
        self.language = profileDictionary.objectForKey("language") as NSString
    }
    
    func getPeopleIdProfilesCurrent(iden: NSString, withToken token: NSString)->Profile{
        var p = Profile()
        
        var profileURL = NSURL(string: baseUrl + "people/" + iden + "/profiles/current?access_token=" + token)
        
        var profileData = NSData.dataWithContentsOfURL(profileURL, options: nil, error: nil)
        
        if (profileData != nil){
            var profileDict = NSJSONSerialization.JSONObjectWithData(profileData, options: nil, error: nil) as NSDictionary
            
            if(profileDict.valueForKey("error")){
                println("error PeopleIdProfilesCurrent Get")
                return p
            }
            p.setDatos(profileDict)
        }
        else {
            println("profile nil")
            return p
        }
        
        return p
    }
    
    func getUserProfilesCurrent(token: NSString)->Profile{
        var p = Profile()
        
        var profileURL = NSURL(string: baseUrl + "user/profiles/current?access_token=" + token)
        
        var profileData = NSData.dataWithContentsOfURL(profileURL, options: nil, error: nil)
        
        if (profileData != nil){
            var profileDict = NSJSONSerialization.JSONObjectWithData(profileData, options: nil, error: nil) as NSDictionary
            
            if(profileDict.valueForKey("error")){
                println("error UserProfilesCurrent Get")
                return p
            }
            p.setDatos(profileDict)
        }
        else {
            println("profile nil")
            return p
        }
        
        return p
    }
    
    func putUserProfilesCurrent(putProfile : Profile, withToken token: NSString)->Profile{
        var p = Profile()
        
        var nouProfile : NSDictionary = ["appId" : putProfile.appId, "app" : putProfile.app, "id" : putProfile.identifier, "userSubtypeId":putProfile.userSubtypeId, "userType":putProfile.userType, "usertypeId":putProfile.usertypeId, "userSubtype":putProfile.userSubtype, "language":putProfile.language] as NSDictionary
        
        var jsonData : NSData = NSJSONSerialization.dataWithJSONObject(nouProfile, options: NSJSONWritingOptions.PrettyPrinted, error: nil) as NSData
        var profileURL = NSURL(string: baseUrl + "user/profiles/current?access_token=" + token)
        var request = NSMutableURLRequest(URL: profileURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var profileData : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        if (profileData != nil){
            var profileDict = NSJSONSerialization.JSONObjectWithData(profileData, options: nil, error: nil) as NSDictionary
            
            if(profileDict.valueForKey("error")){
                println("error PeopleIdProfilesCurrent Put")
                return p
            }
            p.setDatos(profileDict)
        }
        else {
            println("profile nil")
            return p
        }
        
        return p
    }
    
}

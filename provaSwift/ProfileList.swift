//
//  ProfileList.swift
//  Open APIS
//
//  Created by UOC on 04/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class ProfileList: NSObject {
    var profiles = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("profiles").count
        var i = 0
        var auxArray = dict.objectForKey("profiles") as NSMutableArray
        while (i < n){
            var p = Profile()
            p.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.profiles.addObject(p)
            i++
        }
    }
    
    func getPeopleIdProfiles(iden : NSString, withToken token : NSString) -> NSMutableArray{
        self.profiles.removeAllObjects()
        
        var profilesURL = NSURL(string: baseUrl + "people/" + iden + "/profiles?access_token=" + token)
        
        var profilesData = NSData.dataWithContentsOfURL(profilesURL, options: nil, error: nil)
        
        if (profilesData != nil){
            var profilesDict = NSJSONSerialization.JSONObjectWithData(profilesData, options: nil, error: nil) as NSDictionary
            
            if(profilesDict.valueForKey("error")){
                println("error PeopleIdProfiles Get")
                return self.profiles
            }
            self.setDatos(profilesDict)
        }
        else {
            println("profiles nil")
        }
        return self.profiles
    }
    
    func getUserProfiles(token : NSString) -> NSMutableArray{
        self.profiles.removeAllObjects()
        
        var profilesURL = NSURL(string: baseUrl + "user/profiles?access_token=" + token)
        
        var profilesData = NSData.dataWithContentsOfURL(profilesURL, options: nil, error: nil)
        
        if (profilesData != nil){
            var profilesDict = NSJSONSerialization.JSONObjectWithData(profilesData, options: nil, error: nil) as NSDictionary
            
            if(profilesDict.valueForKey("error")){
                println("error UserProfiles Get")
                return self.profiles
            }
            self.setDatos(profilesDict)
        }
        else {
            println("profiles nil")
        }
        return self.profiles
    }
}

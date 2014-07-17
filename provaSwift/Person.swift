//
//  Person.swift
//  Open APIS swift
//
//  Created by UOC on 03/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class Person: NSObject {
    var about : NSString?
    var blog : NSString?
    var email : NSString = ""
    var fullName : NSString = ""
    var hobbies : NSString?
    var identifier : NSString = ""
    var languages : NSString = ""
    var lastUpdate : NSDate?
    var name : NSString = ""
    var ngoes : NSString?
    var personalSite : NSString?
    var profiles = NSMutableArray()
    var secondaryEmail : NSString?
    var skills : NSString?
    var surname1 : NSString = ""
    var surname2 : NSString?
    var userNumber : NSString = ""
    var username : NSString = ""
    
    
    func setDatos(personDictionary : NSDictionary){
        //println(personDictionary.description)
        self.about = personDictionary.objectForKey("about") as? NSString
        self.blog = personDictionary.objectForKey("blog") as? NSString
        self.email = personDictionary.objectForKey("email") as NSString
        self.fullName = personDictionary.objectForKey("fullName") as NSString
        self.hobbies = personDictionary.objectForKey("hobbies") as? NSString
        self.identifier = personDictionary.objectForKey("id") as NSString
        self.languages = personDictionary.objectForKey("languages") as NSString
        var lastUpNum = personDictionary.objectForKey("lastUpdate") as NSNumber
        self.lastUpdate = NSDate(timeIntervalSince1970: (lastUpNum.doubleValue / 1000))
        self.name = personDictionary.objectForKey("name") as NSString
        self.ngoes = personDictionary.objectForKey("ngoes") as? NSString
        self.personalSite = personDictionary.objectForKey("personalSite") as? NSString
        // POSAR PROFILES
        var profilesAux = ProfileList()
        profilesAux.setDatos(personDictionary)
        self.profiles = profilesAux.profiles
        self.secondaryEmail = personDictionary.objectForKey("secondaryEmail") as? NSString
        self.skills = personDictionary.objectForKey("skills") as? NSString
        self.surname1 = personDictionary.objectForKey("surname1") as NSString
        self.surname2 = personDictionary.objectForKey("surname2") as? NSString
        self.userNumber = personDictionary.objectForKey("userNumber") as NSString
        self.username = personDictionary.objectForKey("username") as NSString
    
    }
    
    func getPeopleId(iden: NSString, withToken token : NSString)->Person{
        var p = Person()
        
        var personURL = NSURL(string: baseUrl + "people/" + iden + "?access_token=" + token)

        var personData : NSData = NSData.dataWithContentsOfURL(personURL, options: nil, error: nil)

        if (personData != nil){
            var personDict = NSJSONSerialization.JSONObjectWithData(personData, options: nil, error: nil) as NSDictionary
            
            if(personDict.valueForKey("error")){
                println("error getPeopleId")
                return p
            }
            p.setDatos(personDict)
        }
        return p
    }
}

//
//  SettingList.swift
//  Open APIS
//
//  Created by UOC on 07/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class SettingList: NSObject {
    var settings = NSMutableArray()
    
    func setDatos(dict : NSDictionary){
        var n = dict.objectForKey("settings").count
        var i = 0
        var auxArray = dict.objectForKey("settings") as NSMutableArray
        while (i < n){
            var s = Setting()
            s.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.settings.addObject(s)
            i++
        }
    }
    
    func getUserSettings(token : NSString) -> NSMutableArray{
        self.settings.removeAllObjects()
        
        var settingsURL = NSURL(string: baseUrl + "user/settings?access_token=" + token)
        
        var settingsData = NSData.dataWithContentsOfURL(settingsURL, options: nil, error: nil)
        
        if(settingsData != nil){
            var settingsDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(settingsData, options: nil, error: nil) as NSDictionary
            
            if(settingsDict.valueForKey("error")){
                println("error en userSettings GET")
                return self.settings
            }
            self.setDatos(settingsDict)
        }
        else {
            println("settingsData nil")
        }
        return self.settings
    }
}

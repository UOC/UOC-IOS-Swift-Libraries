//
//  EventList.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 23/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class EventList: NSObject {
    var events = NSMutableArray()
    
    func setDatos(dict: NSDictionary){
        var n = dict.objectForKey("events").count
        var i = 0
        var auxArray = dict.objectForKey("events") as NSMutableArray
        while (i < n){
            var e = Event()
            e.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.events.addObject(e)
            i++
        }
    }
    
    func getCalendarEvents(token: NSString) -> NSMutableArray{
        self.events.removeAllObjects()
        
        var eventsURL = NSURL(string: baseUrl + "calendar/events?access_token=" + token)
        
        var eventsData = NSData.dataWithContentsOfURL(eventsURL, options: nil, error: nil)
        
        if (eventsData != nil){
            var eventsDict = NSJSONSerialization.JSONObjectWithData(eventsData, options: nil, error: nil) as NSDictionary
            if (eventsDict.valueForKey("error") != nil){
                println("Error en events Get")
                return self.events
            }
            println(eventsDict.description)
            self.setDatos(eventsDict)
        }
        
        
        return self.events
    }

}

//
//  Event.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 23/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit
import Foundation

class Event: NSObject {
    
    var identifier  : NSString = ""
    var url         : NSString = ""
    var summary     : NSString = ""
    var start       : NSDate?
    var end         : NSDate?
    
    func setDatos(eventDict : NSDictionary){
        self.identifier = eventDict.objectForKey("id") as NSString
        self.url = eventDict.objectForKey("url") as NSString
        self.summary = eventDict.objectForKey("summary") as NSString
        self.start = self.parseDate(eventDict.objectForKey("start") as NSString)
        self.end = self.parseDate(eventDict.objectForKey("end") as NSString)
    }
    
    func parseDate(dateString: NSString)->NSDate{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSz"
        return dateFormatter.dateFromString(dateString)
    }
    
    func getCalendarEventsId(iden: NSString, withToken token: NSString) -> Event{
        var e : Event = Event()
        
        var eventURL = NSURL(string: baseUrl + "calendar/events/" + iden + "?access_token=" + token)
        
        var eventData = NSData.dataWithContentsOfURL(eventURL, options: nil, error: nil)
        
        if (eventData != nil){
            var eventDict = NSJSONSerialization.JSONObjectWithData(eventData, options: nil, error: nil) as NSDictionary
            if (eventDict.valueForKey("error")){
                println("Error en get Calendar Events Id")
                return e
            }
            
            e.setDatos(eventDict)
        }
        
        return e
    }
    
    func postCalendarEvents(postEvent : Event, withToken token: NSString) -> Event{
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        var nouEvent : NSDictionary = ["id":postEvent.identifier,"url":postEvent.url,"summary":postEvent.summary,"start":dateFormatter.stringFromDate(postEvent.start),"end":dateFormatter.stringFromDate(postEvent.end)] as NSDictionary
        var jsonData : NSData = NSJSONSerialization.dataWithJSONObject(nouEvent, options: NSJSONWritingOptions.PrettyPrinted, error: nil) as NSData
        
        var eventURL = NSURL(string: baseUrl + "calendar/events?access_token=" + token)
        
        var request = NSMutableURLRequest(URL: eventURL)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonData
        
        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        var e : Event = Event()
        
        if (data != nil){
            var eventDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if (eventDict.valueForKey("error")){
                println("Error Post Calendar Events")
                return e
            }
            e.setDatos(eventDict)
        }
        
        return e
    }
    
}

//
//  MessageHistoryDetail.swift
//  Open APIS
//
//  Created by UOC on 07/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

//import UIKit
import Foundation


class MessageHistoryDetail: NSObject {
    var action : NSString = ""
    var date : NSString = ""
    var name : NSString = ""
    var time : NSString = ""
    
    func setDatos(dict : NSDictionary){
        self.action = dict.objectForKey("action") as NSString
        self.date = dict.objectForKey("date") as NSString
        self.name = dict.objectForKey("name") as NSString
        self.time = dict.objectForKey("time") as NSString
    }
}

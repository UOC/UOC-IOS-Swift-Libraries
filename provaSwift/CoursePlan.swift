//
//  CoursePlan.swift
//  Open APIS
//
//  Created by UOC on 07/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class CoursePlan: NSObject {
    var contentType : NSString = ""
    var format : NSString = ""
    var url: NSString = ""
    
    func setDatos(dict : NSDictionary){
        self.contentType = dict.objectForKey("contentType") as NSString
        self.format = dict.objectForKey("format") as NSString
        self.url = dict.objectForKey("url") as NSString
    }
}

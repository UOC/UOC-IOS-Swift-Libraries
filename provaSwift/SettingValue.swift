//
//  SettingValue.swift
//  Open APIS
//
//  Created by UOC on 07/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class SettingValue: NSObject {
    var descript : NSString = ""
    var value : NSString = ""
    
    func setDatos(valueDict : NSDictionary){
        self.descript = valueDict.objectForKey("description") as NSString
        self.value = valueDict.objectForKey("value") as NSString
    }
}

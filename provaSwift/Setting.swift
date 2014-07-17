//
//  Setting.swift
//  Open APIS
//
//  Created by UOC on 04/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class Setting: NSObject {
    var identifier : NSString = ""
    var title : NSString = ""
    var descript : NSString = ""
    var section : NSString = ""
    var url : NSString = ""
    var value : NSString = ""
    var values = NSMutableArray()
    
    func setDatos(dict : NSDictionary){
        self.values.removeAllObjects()
        self.identifier = dict.objectForKey("id") as NSString
        self.title = dict.objectForKey("title") as NSString
        self.descript = dict.objectForKey("description") as NSString
        self.section = dict.objectForKey("section") as NSString
        self.url = dict.objectForKey("url") as NSString
        self.value = dict.objectForKey("value") as NSString
        var n = dict.objectForKey("values").count
        var i = 0
        var auxArray = dict.objectForKey("values") as NSMutableArray
        while (i < n){
            var sv = SettingValue()
            sv.setDatos(auxArray.objectAtIndex(i) as NSDictionary)
            self.values.addObject(sv)
            i++
        }
    }
}

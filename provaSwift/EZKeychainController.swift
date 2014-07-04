//
//  EZKeychainController.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 13/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit
import Security


class EZKeychainController: NSObject {
    
    //static var sharedInstance : EZKeychainController
    
//    class var sharedInstance : EZKeychainController {
//        struct Static {
//            static var onceQueue : dispatch_once_t = 0
//            static var instance : EZKeychainController? = nil
//        }
//        
//    }
//    
//    func sharedKeychainController() -> EZKeychainController{
//        dispatch_once(&Static.onceQueue){
//            self.Static.instance = self
//        }
//        return Static.instance!
//        
//    }
    
    
    func serviceName() -> NSString
    {
        return NSBundle.mainBundle().bundleIdentifier
    }
    
    func stringForKey(key: NSString) -> NSString?
    {
        var status : OSStatus
        //var query = NSDictionary(objects: kSecClassGenericPassword, key, self.serviceName(), forKeys: kSecClass,kSecAttrAccount,kSecAttrService)
        //var objAndK = [kSecClassGenericPassword, kSecClass, key, kSecAttrAccount, self.serviceName(), kSecAttrService] as AnyObject[]
        var query = [
            Unmanaged<NSData>.fromOpaque(kSecClass.toOpaque()).takeUnretainedValue() : Unmanaged<NSData>.fromOpaque(kSecClassGenericPassword.toOpaque()).takeUnretainedValue(),
            Unmanaged<NSData>.fromOpaque(kSecAttrAccount.toOpaque()).takeUnretainedValue() : key,
            Unmanaged<NSData>.fromOpaque(kSecAttrService.toOpaque()).takeUnretainedValue() : self.serviceName(),
            Unmanaged<NSData>.fromOpaque(kSecReturnData.toOpaque()).takeUnretainedValue() : true] as NSDictionary
        var stringData : Unmanaged<AnyObject>?
        status = SecItemCopyMatching(query as CFDictionaryRef, &stringData)
        if (status != 0){
            //println(status.description)
            return nil
        }
        else {
            //println("Else")
            let opaque = stringData?.toOpaque()
            if let op = opaque? {
                //println("if let")
                let laData = Unmanaged<NSData>.fromOpaque(op).takeUnretainedValue()
                //println("Hola - " + laData.description)
                var string : NSString = NSString(data: laData, encoding: NSUTF8StringEncoding)
                return string
            }
            else {
                // println("no if let")
                return nil
            }
        }

    }
    
    func storeString(string: NSString, forKey key: NSString)->Bool{
        return self.storeString(string, forKey: key, accessibleAttribute: kSecAttrAccessibleWhenUnlocked)
    }
    
    func storeString(string: NSString, forKey key: NSString, accessibleAttribute: Unmanaged<AnyObject>!) -> Bool{
        if(string == ""){
            //var spec = NSDictionary(objects: kSecClassGenericPassword, key, self.serviceName(), forKeys: kSecClass,kSecAttrAccount,kSecAttrService)
            var spec = [
                Unmanaged<NSData>.fromOpaque(kSecClass.toOpaque()).takeUnretainedValue() : Unmanaged<NSData>.fromOpaque(kSecClassGenericPassword.toOpaque()).takeUnretainedValue(),
                Unmanaged<NSData>.fromOpaque(kSecAttrAccount.toOpaque()).takeUnretainedValue() : key,
                Unmanaged<NSData>.fromOpaque(kSecAttrService.toOpaque()).takeUnretainedValue() : self.serviceName()] as NSDictionary
            var result : OSStatus = SecItemDelete(spec as CFDictionaryRef)
            if(result != 0){
                println("Could not store(Delete) string. Error was: " + result.description)
                return false
            }
            //println("deleted")
            return true
        }
        else {
            var stringData = string.dataUsingEncoding(NSUTF8StringEncoding)
            var spec = [
                Unmanaged<NSData>.fromOpaque(kSecClass.toOpaque()).takeUnretainedValue() : Unmanaged<NSData>.fromOpaque(kSecClassGenericPassword.toOpaque()).takeUnretainedValue(),
                Unmanaged<NSData>.fromOpaque(kSecAttrAccount.toOpaque()).takeUnretainedValue() : key,
                Unmanaged<NSData>.fromOpaque(kSecAttrService.toOpaque()).takeUnretainedValue() : self.serviceName()] as NSDictionary
            if(string == ""){
                var result : OSStatus = SecItemDelete(spec as CFDictionaryRef)
                if(result != 0){
                    println("Could not store(Delete) string. Error was: " + result.description)
                    return false
                }
                //println("deleted")
                return true
            }
            else if(self.stringForKey(key) != nil){
                //var update = NSDictionary(objectsAndKeys: accessibleAttribute, kSecAttrAccessible, stringData, kSecValueData)
                var update = [
                    Unmanaged<NSData>.fromOpaque(kSecAttrAccessible.toOpaque()).takeUnretainedValue() : Unmanaged<NSData>.fromOpaque(accessibleAttribute.toOpaque()).takeUnretainedValue(),
                    Unmanaged<NSData>.fromOpaque(kSecValueData.toOpaque()).takeUnretainedValue() : stringData] as NSDictionary
                var result : OSStatus = SecItemUpdate(spec as CFDictionaryRef, update as CFDictionaryRef)
                if (result != 0){
                    println("Could not store(Update) string. Error was: " + result.description)
                    return false
                }
                //println("updated")
                return true
            }
            else {
                
                //var data = NSDictionary(objectsAndKeys: kSecClassGenericPassword, kSecClass, key, kSecAttrAccount, self.serviceName(), kSecAttrService, accessibleAttribute, kSecAttrAccessible, stringData, kSecValueData)
                
                var data = [
                    Unmanaged<NSData>.fromOpaque(kSecClass.toOpaque()).takeUnretainedValue() : Unmanaged<NSData>.fromOpaque(kSecClassGenericPassword.toOpaque()).takeUnretainedValue(),
                    Unmanaged<NSData>.fromOpaque(kSecAttrAccount.toOpaque()).takeUnretainedValue() : key,
                    Unmanaged<NSData>.fromOpaque(kSecAttrService.toOpaque()).takeUnretainedValue() : self.serviceName(),
                    Unmanaged<NSData>.fromOpaque(kSecAttrAccessible.toOpaque()).takeUnretainedValue() : Unmanaged<NSData>.fromOpaque(accessibleAttribute.toOpaque()).takeUnretainedValue(),
                    Unmanaged<NSData>.fromOpaque(kSecValueData.toOpaque()).takeUnretainedValue() : stringData] as NSDictionary
                var result : OSStatus = SecItemAdd(data as CFDictionaryRef, nil)
                if (result != 0){
                    println("Could not store(Add) string. Error was: " + result.description)
                    return false
                }
                //println("added " + NSString(data: stringData, encoding: NSUTF8StringEncoding))
                return true
            }
        }
    }
    
    func removeStringForKey(key :NSString)->Bool{
        return self.storeString("", forKey: key, accessibleAttribute: kSecAttrAccessibleWhenUnlocked)
    }
    
}

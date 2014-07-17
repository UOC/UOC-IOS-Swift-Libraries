//
//  authObj.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 06/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class authObj: NSObject {
    
    var accessToken:NSString = ""
    var tokenType:NSString = ""
    var refreshToken:NSString = ""
    var expiresIn:NSNumber = 0
    var scope:NSString = ""
    var expirationDate:NSDate = NSDate.date()
    
    func setAuth(dict: NSDictionary){
        accessToken = dict.objectForKey("access_token") as NSString
        tokenType = dict.objectForKey("token_type") as NSString
        refreshToken = dict.objectForKey("refresh_token") as NSString
        expiresIn = dict.objectForKey("expires_in") as NSNumber
        scope = dict.objectForKey("scope") as NSString
        updateExpirationDate()
    }
    
    func updateExpirationDate(){
        if (expiresIn != nil){
            var deltaSeconds = expiresIn.unsignedLongValue
            
            if (deltaSeconds > 0){
                var deltaSecond2 : NSTimeInterval = expiresIn.doubleValue
                expirationDate = NSDate.date().dateByAddingTimeInterval(deltaSecond2)
            }
        }
    }
    
    func shouldRefreshToken()->Bool{
        var shouldRefresh = false
        var hasRefreshToken = (refreshToken.length > 0)
        var hasAccessToken = (accessToken.length > 0)
        if (hasRefreshToken){
            if(!hasAccessToken){
                shouldRefresh = true
            }
            else {
                var timeToExpire = expirationDate.timeIntervalSinceNow
                if (expirationDate == nil || timeToExpire < 60.0){
                    shouldRefresh = true
                }
            }
            
        }
        return shouldRefresh
    }
    
    
    
    func refreshAccessToken(){
        println("entra refresh amb RT = "+refreshToken)
        var stdDefaults = NSUserDefaults.standardUserDefaults()
        
        // S'ha de fer amb KeyChain mentrestant
        var clauer = EZKeychainController()
        
        var postString : NSString = "client_id="+clauer.stringForKey("client")!+"&client_secret="+clauer.stringForKey("secret")!+"&grant_type=refresh_token&refresh_token="+refreshToken
        
        //println("PostString : " + postString)
        
        var tokenRequest = NSMutableURLRequest(URL: NSURL(string: urlToken))
        tokenRequest.HTTPMethod = "POST"
        tokenRequest.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        var response : NSURLResponse?
        var error : NSError?
        
        var data = NSURLConnection.sendSynchronousRequest(tokenRequest, returningResponse:&response, error:&error)
        
        if (data != nil){
            var oAuth = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&error) as NSDictionary
            stdDefaults.setValue("OK", forKey: "access_token")
            stdDefaults.setValue("OK", forKey: "refresh_token")
            
            clauer.storeString(oAuth.objectForKey("access_token") as NSString, forKey: "access_token")
            clauer.storeString(oAuth.objectForKey("refresh_token") as NSString, forKey: "refresh_token")
            println(oAuth.description)
            setAuth(oAuth)
        }
        
    }
    
}

//
//  Constants.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 06/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

//var servidor : NSString = "54.75.227.139:8080/"
var servidor : NSString = "oslo.uoc.es:8080/webapps/"


    let keychainName = "OpenApi_UOC"
    let urlToken     = "http://"+servidor+"uocapi/oauth/token"
    let urlAuth      = "http://"+servidor+"uocapi/oauth/authorize"
    let urlApp       = "http://"+servidor+"uocapi/api/v1/app"
    let baseUrl      = "http://"+servidor+"uocapi/api/v1/"
    let urlRedirect  = "openApi://"+servidor+"uocapi/api/v1/"
    
    let idClient : NSString    = "EUI3WhtdZMjwOLxwFyzUcLUUXeE0ACmB6See1HWRjoCSIgGJ1If8EI8EPorzSWFRRnw1fxkOvIqkBI1d91GGKKG6nFnD35OY6VOEx4LcFLQIW3Z2jGsTaYey4bUcbR4K" // S'ha de canviar per el client que s'ha donat especificament per la seva app
    let secretClient = "scR6rJl1nssYW3I2gYaUslSsBKSMeMOp8EoyEuLgJ61MmQgtaTSBAgIknrqBqO4L26wMXWVkz5Z7WJtCyZ9huK33Z1JU95vqNbKRDRv0CoAa5z6WPdSBe5c75N5tRf2R" // S'ha de canviar per el secret que s'ha donat especificament per la seva app

class Constants: NSObject {
    
}

//
//  ViewController.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 04/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1 : UIButton
    @IBOutlet var loading : UIActivityIndicatorView
    
    var auth : authObj = authObj()
    
    var viewController = WebViewController(nibName: "webView", bundle:nil)
    
    @IBAction func button1Clicked (sender : AnyObject) {
        println("Hola")
        ferLogin()
    }
    
    func ferLogin(){
        var stdDefaults = NSUserDefaults.standardUserDefaults()
        if (stdDefaults.objectForKey("registrada") == nil){
            self.viewController.extra = "device=" + UIDevice.currentDevice().name.stringByReplacingOccurrencesOfString(" ", withString: "%20") + "&"
            navigationController.pushViewController(viewController, animated: true)
        }
        else {
            self.loading.startAnimating()
            self.loading.hidden = false
            self.button1.enabled = false
            var clauer = EZKeychainController()

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.auth.refreshToken = clauer.stringForKey("refresh_token")!
                self.auth.refreshAccessToken()
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.button1.enabled = true
                    self.loading.stopAnimating()
                    self.loading.hidden = true
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    if (self.auth.accessToken != ""){
                        self.goToNextView()
                    }
                    else {
                        var alert = UIAlertController(title: "LOGIN ERROR", message: "You need internet connection.\nIf you have internet connection, you should Log Out.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                })
                
            })
            //var user = User().getUser(auth.accessToken)
            //println(user.fullname)
        }
    }
    
    func goToNextView(){
        var nextView : NextViewController = storyboard.instantiateViewControllerWithIdentifier("nextView") as NextViewController
        nextView.auth = auth
        navigationController.pushViewController(nextView, animated: true)
    }
    
    @IBAction func esborrar() {
        borraVariables()
    }
    
    func borraVariables(){
        println("Esborrar")
        
        var stdDefaults = NSUserDefaults.standardUserDefaults()
        stdDefaults.removeObjectForKey("registrada")
        stdDefaults.removeObjectForKey("access_token")
        stdDefaults.removeObjectForKey("secret")
        stdDefaults.removeObjectForKey("nextView")
        stdDefaults.removeObjectForKey("client")
        stdDefaults.removeObjectForKey("refresh_token")
        
        // Eliminar les coses de la keychain
        var clauer = EZKeychainController()
        clauer.removeStringForKey("access_token")
        clauer.removeStringForKey("client")
        clauer.removeStringForKey("refresh_token")
        clauer.removeStringForKey("secret")
        //var cookie = NSHTTPCookie()
        var storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie : AnyObject in storage.cookies{
            println("elimina")
            storage.deleteCookie(cookie as NSHTTPCookie)
        }
        stdDefaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        var stdDefaults = NSUserDefaults.standardUserDefaults()
        var clauer = EZKeychainController()
        if (stdDefaults.objectForKey("nextView") == nil) {
            if (stdDefaults.objectForKey("registrada") != nil) {
                if (stdDefaults.objectForKey("secret") == nil) {
                    // afegir el loading
                    self.button1.enabled = false
                    self.loading.startAnimating()
                    self.loading.hidden = false
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        if(self.viewController.receivedData != nil){
                            var oAuth = NSJSONSerialization.JSONObjectWithData(self.viewController.receivedData, options: nil, error: nil) as NSDictionary
                            self.auth.setAuth(oAuth)
                            var obtenirCredencials = NSURL(string: urlApp + "?access_token=" + self.auth.accessToken)
                            var credencials = NSData.dataWithContentsOfURL(obtenirCredencials, options: nil, error: nil)
                            var credencialsDict = NSJSONSerialization.JSONObjectWithData(credencials, options: nil, error: nil) as NSDictionary
                            stdDefaults.setValue("OK", forKey: "secret")
                            stdDefaults.setValue("OK", forKey: "client")
                            stdDefaults.setValue("OK", forKey: "access_token")
                            
                            clauer.storeString(credencialsDict.valueForKey("secret") as NSString, forKey: "secret")
                            clauer.storeString(credencialsDict.valueForKey("client") as NSString, forKey: "client")
                            clauer.storeString(credencialsDict.valueForKey("name") as NSString, forKey: "access_token")
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                self.button1.enabled = true
                                self.loading.stopAnimating()
                                self.loading.hidden = true
                                // Parar animacions
                                self.goToNextView()
                                
                                })
                        }
                        else {
                            self.borraVariables()
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                // Parar animacions
                                self.button1.enabled = true
                                self.loading.stopAnimating()
                                self.loading.hidden = true
                                })
                        }
                    })
                }
                else {
                    println("Secret Cert")
                }
            }
        }
        else {
            if (self.viewController.receivedData != nil) {
                var oAuth = NSJSONSerialization.JSONObjectWithData(self.viewController.receivedData, options: nil, error: nil) as NSDictionary
                self.auth.setAuth(oAuth)
                self.goToNextView()
            }
        }
    }
}


//
//  WebViewController.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 05/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate{

    @IBOutlet var WebView : UIWebView
    
    var receivedData : NSMutableData = NSMutableData()
    
    var extra : NSString = ""
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.WebView.delegate = self
        var urlReq = NSURL(string: "\(urlAuth)?\(self.extra)client_id=\(idClient)&redirect_uri=\(urlRedirect)&response_type=code")
        var req = NSURLRequest(URL: urlReq)
        self.WebView.scalesPageToFit = true
        self.WebView.loadRequest(req)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView!,
        shouldStartLoadWithRequest request: NSURLRequest!,
        navigationType: UIWebViewNavigationType) -> Bool{
            var urlRequest = request.URL.absoluteString
            //println(urlRequest)
            if (urlRequest.rangeOfString("?code=").isEmpty) {
                //println("No token request provided")
                return true
            }
            else {
                var separats = urlRequest.componentsSeparatedByString("?code=")
                var tokenRequestCode = separats[1]
                accessTokenGET(tokenRequestCode)
                return false
            }
    }
    
    func webViewDidStartLoad(webView: UIWebView){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func accessTokenGET(code: NSString){
        var postString = "client_id=\(idClient)&client_secret=\(secretClient)&grant_type=authorization_code&code=\(code)&redirect_uri=\(urlRedirect)"
        var url = NSURL(string: urlToken)
        var request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        request.HTTPMethod = "POST"
        var connect = NSURLConnection(request: request, delegate:self)

        /*
        
        */
    }
    
//   #pragma mark - NSURLConnectionDelegate methods
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        //self.receivedData = nil
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data:NSData!){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        var stdDefaults = NSUserDefaults.standardUserDefaults()
        
        // Falta keychain
        
        var tokens = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
        
        // Mentre no fem el keychain fem servir els userDefaults
        stdDefaults.setValue("OK", forKey: "access_token")
        stdDefaults.setValue("OK", forKey: "refresh_token")
        
        var clauer = EZKeychainController()
        clauer.storeString(tokens.valueForKey("access_token") as NSString, forKey: "access_token")
        clauer.storeString(tokens.valueForKey("refresh_token") as NSString, forKey: "refresh_token")
        
        stdDefaults.setBool(true, forKey: "registrada")
        
        if (self.receivedData == nil){
            //println("nil")
            self.receivedData = NSMutableData()
            self.receivedData.appendData(data)
            stdDefaults.synchronize()
            navigationController.popViewControllerAnimated(true)
        }
        else{
            //println("no nil")
            receivedData.appendData(data)
            stdDefaults.synchronize()
            navigationController.popViewControllerAnimated(true)
        }
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!){
        println("connection did fail")
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

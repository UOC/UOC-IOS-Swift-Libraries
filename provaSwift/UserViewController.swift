//
//  UserViewController.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 19/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet var username : UILabel
    @IBOutlet var name : UILabel
    @IBOutlet var number : UILabel
    @IBOutlet var fullname : UILabel
    @IBOutlet var email : UILabel
    @IBOutlet var ident : UILabel
    @IBOutlet var languages : UILabel
    @IBOutlet var sessionId : UILabel
    @IBOutlet var imageUser : UIImageView
    
    
    var user : User = User()
    
    var auth : authObj = authObj()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarUsuario()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func cargarUsuario (){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var backgroudQueue : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        dispatch_async(backgroudQueue, {
            
            if(self.auth.shouldRefreshToken()) {
                self.auth.refreshAccessToken()
            }
            self.user = User().getUser(self.auth.accessToken)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.mostrarDatosUsuario()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
            
            })
    }
    
    func mostrarDatosUsuario(){
        self.username.text = "Username: " + self.user.username
        self.name.text = "name: " + self.user.name
        self.number.text = "number: " + self.user.number
        self.fullname.text = "fullName: " + self.user.fullname
        self.email.text = "email: " + self.user.email
        self.ident.text = "id: " + self.user.identifier
        self.languages.text = "language: " + self.user.language
        self.sessionId.text = "sessionId: " + self.user.sessionID
        self.imageUser.image = self.user.photo
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

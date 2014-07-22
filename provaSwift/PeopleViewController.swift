//
//  PeopleViewController.swift
//  Open APIS swift
//
//  Created by UOC on 03/07/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    
    @IBOutlet var fullName: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var personalSite: UILabel!
    @IBOutlet var blog: UILabel!
    @IBOutlet var profileId: UILabel!
    
    var person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mostrarPerson()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mostrarPerson(){
        self.fullName.text = "fullName: \(person.fullName)"
        self.email.text = "email: \(person.email)"
        if (person.personalSite != nil) {self.personalSite.text = "personalSite: \(person.personalSite!)"}
        else {
            self.personalSite.text = "personalSite: NULL"
        }
        if(person.blog != nil) {self.blog.text = "blog: " + person.blog!}
        else{
            self.blog.text = "blog: NULL"
        }
        var p = person.profiles.objectAtIndex(0) as Profile
        self.profileId.text = "Profile id: \(p.identifier)"
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

//
//  NewEventViewController.swift
//  Open APIS swift
//
//  Created by UOC on 23/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    var event = Event()
    var creat = false
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func creaEvent(sender: AnyObject) {
        self.agafarDades()
    }
    @IBOutlet var url: UITextField
    
    @IBOutlet var summary: UITextField
    
    @IBOutlet var inici: UIDatePicker

    @IBOutlet var final: UIDatePicker
    
    
    
    func agafarDades(){
        var urlT = self.url.text
        var summaryT = self.summary.text
        var dInici = self.inici.date
        var dFinal = self.final.date
        self.event.url = urlT
        self.event.summary = summaryT
        self.event.start = dInici
        self.event.end = dFinal
        self.event.identifier = "1"
        self.creat = true
        println("ADEU!")
        navigationController.popViewControllerAnimated(true)
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

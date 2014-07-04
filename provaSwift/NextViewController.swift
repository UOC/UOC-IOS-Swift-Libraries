//
//  NextViewController.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 06/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBAction func classroomsTableV() {
        self.goToClassroomsGet()
    }
    @IBAction func calendarEvents() {
        self.goToCalendarEvents()
    }
    @IBAction func userView(){
        self.goToUserView()
    }
    
    @IBAction func mobileResources(){
        self.goToMobileResourcesView()
    }
    @IBAction func peopleTV() {
        self.goToPeopleGet()
    }
    var auth : authObj = authObj()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToClassroomsGet(){
        var classroomsTV : ClassroomsTableViewController = storyboard.instantiateViewControllerWithIdentifier("classroomsTable") as ClassroomsTableViewController
        classroomsTV.auth = auth
        navigationController.pushViewController(classroomsTV, animated: true)
    }
    
    func goToCalendarEvents(){
        var calendarEventsView : CalendarEventsTableViewController = storyboard.instantiateViewControllerWithIdentifier("calendarEvents") as CalendarEventsTableViewController
        calendarEventsView.auth = auth
        navigationController.pushViewController(calendarEventsView, animated: true)
        
    }
    
    func goToUserView(){
        var userView : UserViewController = storyboard.instantiateViewControllerWithIdentifier("userView") as UserViewController
        userView.auth = auth
        navigationController.pushViewController(userView, animated: true)
    }

    func goToMobileResourcesView(){
        var resourcesView : MobileResourcesTableViewController = storyboard.instantiateViewControllerWithIdentifier("mresourcesView") as MobileResourcesTableViewController
        resourcesView.auth = auth
        navigationController.pushViewController(resourcesView, animated: true)
    }
    
    func goToPeopleGet(){
        var peopleTaV : PeopleTableViewController = storyboard.instantiateViewControllerWithIdentifier("peopleGet") as PeopleTableViewController
        peopleTaV.auth = auth
        navigationController.pushViewController(peopleTaV, animated: true)
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

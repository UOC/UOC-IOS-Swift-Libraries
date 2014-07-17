//
//  CalendarEventsTableViewController.swift
//  Open APIS swift
//
//  Created by Pau Castells Diumenjo and UOC on 23/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class CalendarEventsTableViewController: UITableViewController {

    var newEventV = NewEventViewController(nibName: "NewEventView", bundle: nil)
    
    @IBAction func postEvent(sender: AnyObject) {
        self.navigationController.pushViewController(self.newEventV, animated: true)
    }
    var events = NSMutableArray()
    
    var auth = authObj()
    
    //    init(style: UITableViewStyle) {
    //        super.init(style: style)
    //        // Custom initialization
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carregarEvents()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        println("HOLA!")
        if (self.newEventV.creat == true){
            self.newEventV.creat = false
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            println("HOLA2!")
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                if (self.auth.shouldRefreshToken()) {
                    self.auth.refreshAccessToken()
                }
                var e : Event = Event().postCalendarEvents(self.newEventV.event, withToken: self.auth.accessToken)
                
                dispatch_async(dispatch_get_main_queue(), {
                    println("Creat " + e.identifier)
                    self.carregarEvents()
                    self.newEventV = NewEventViewController(nibName: "NewEventView", bundle: nil)
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    })
                })
        }
    }
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return events.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var event : Event = self.events.objectAtIndex(indexPath!.row) as Event
        
        var CellIdentifier = event.summary
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel.text = CellIdentifier
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func carregarEvents(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            if (self.auth.shouldRefreshToken()) {
                self.auth.refreshAccessToken()
            }
            self.events = EventList().getCalendarEvents(self.auth.accessToken)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
            })
    }
    /*
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

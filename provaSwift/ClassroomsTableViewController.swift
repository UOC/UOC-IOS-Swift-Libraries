//
//  ClassroomsTableViewController.swift
//  Open APIS swift
//
//  Created by UOC on 27/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class ClassroomsTableViewController: UITableViewController {

    var classrooms = NSMutableArray()
    
    var auth = authObj()
    
    //    init(style: UITableViewStyle) {
    //        super.init(style: style)
    //        // Custom initialization
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carregarClassrooms()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return classrooms.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var clsroom : Classroom = self.classrooms.objectAtIndex(indexPath!.row) as Classroom
        
        var CellIdentifier = clsroom.title
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.text = CellIdentifier
        var hex = clsroom.color
        
        var colorCella = UIColor()
        
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(1)
        }
        
        if (countElements(cString) != 6) {
            colorCella = UIColor.grayColor()
        }
        
        var rString = cString.substringFromIndex(0).substringToIndex(2)
        var gString = cString.substringFromIndex(2).substringToIndex(4)
        var bString = cString.substringFromIndex(4).substringToIndex(6)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner.scannerWithString(rString).scanHexInt(&r)
        NSScanner.scannerWithString(gString).scanHexInt(&g)
        NSScanner.scannerWithString(bString).scanHexInt(&b)
        
        colorCella =  UIColor(red: Float(r)/255.0, green: Float(g)/255.0, blue: Float(b)/255.0, alpha: Float(1))
        // Configure the cell...
        cell.backgroundColor = colorCella
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        var teachMatTV : TeachingMaterialsTableViewController = storyboard.instantiateViewControllerWithIdentifier("tmaterialsTable") as TeachingMaterialsTableViewController
        teachMatTV.auth = auth
        teachMatTV.aula = classrooms.objectAtIndex(indexPath.row) as Classroom
        navigationController.pushViewController(teachMatTV, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func carregarClassrooms(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            if (self.auth.shouldRefreshToken()) {
                self.auth.refreshAccessToken()
            }
            self.classrooms = ClassroomList().getClassrooms(self.auth.accessToken)
            
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

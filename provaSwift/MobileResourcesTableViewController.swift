//
//  MobileResourcesTableViewController.swift
//  Open APIS swift
//
//  Created by UOC on 19/06/14.
//  Copyright (c) 2014 UOC. All rights reserved.
//

import UIKit

class MobileResourcesTableViewController: UITableViewController {

    var resources = NSMutableArray()
    
    var auth = authObj()
    
//    init(style: UITableViewStyle) {
//        super.init(style: style)
//        // Custom initialization
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.carregarResources()
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
        return resources.count
    }

    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var app : MobileResource = self.resources.objectAtIndex(indexPath!.row) as MobileResource
        
        var CellIdentifier = app.nameIOS
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")

        cell.textLabel.text = CellIdentifier
        
        // Here the application stores the data from the logo of the other application.
        // If we store the images we save network connections and we can get the logos faster.
        
        var stdDefaults = NSUserDefaults.standardUserDefaults()
        
        // We check if the logo is stored
        if(stdDefaults.objectForKey("\(app.nameIOS)URL")){
            if(stdDefaults.objectForKey("\(app.nameIOS)URL") as NSString == app.logoIOS){
                var image = UIImage(data: stdDefaults.objectForKey("\(app.nameIOS)Data") as NSData)
                cell.imageView.image = image
            }
            else {
                // Esborrar
                stdDefaults.setObject(app.logoIOS, forKey: "\(app.nameIOS)URL")
                var logoURL = NSURL(string: app.logoIOS)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                var imageData = NSData(contentsOfURL: logoURL)
                stdDefaults.setObject(imageData, forKey: "\(app.nameIOS)Data")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                var image = UIImage(data: imageData)
                cell.imageView.image = image
            }
        }
        else {
            stdDefaults.setObject(app.logoIOS, forKey: "\(app.nameIOS)URL")
            var logoURL = NSURL(string: app.logoIOS)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            var imageData = NSData(contentsOfURL: logoURL)
            stdDefaults.setObject(imageData, forKey: "\(app.nameIOS)Data")
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            var image = UIImage(data: imageData)
            cell.imageView.image = image
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var aux = self.resources.objectAtIndex(indexPath.row) as MobileResource
        var myURL = NSURL(string: aux.urlIOS)
        
        if(UIApplication.sharedApplication().canOpenURL(myURL)){
            UIApplication.sharedApplication().openURL(myURL)
        }
        else{
                var marketUrl = NSURL(string: aux.urlMarketIOS)
                UIApplication.sharedApplication().openURL(marketUrl)

        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func carregarResources(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            if (self.auth.shouldRefreshToken()) {
                self.auth.refreshAccessToken()
            }
            self.resources = MobileResourceList().getMobileResources(self.auth.accessToken)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        })
    }
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

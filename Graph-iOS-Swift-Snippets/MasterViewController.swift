/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil

    var authentication: Authentication!
    var snippets: Snippets!
    
    var objects = [AnyObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        snippets = Snippets(with: authentication.authenticationProvider!)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let snippet = snippets[indexPath.section][indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                controller.snippet = snippet
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true

            }
        }
    }

    @IBAction func disconnect(sender: AnyObject) {
        self.authentication.disconnect()
        self.navigationController?.splitViewController?.dismissViewControllerAnimated(true, completion: nil)


    }

}

// MARK: - Table View
extension MasterViewController {

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snippets[section].name
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return snippets.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snippets[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let snippet = snippets[indexPath.section][indexPath.row]
        
        cell.textLabel!.text = snippet.name
        if snippet.needAdminAccess {
            cell.detailTextLabel!.text = "Need admin access"
        }
        else {
            cell.detailTextLabel!.text = ""
        }
        
        return cell
    }
}
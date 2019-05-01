/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import UIKit

class MasterViewController: UITableViewController
{
    var detailViewController: DetailViewController?
    var authenticationProvider: AuthenticationProvider!
    var snippets: Snippets!
    var objects = [AnyObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        snippets = Snippets(authenticationProvider: authenticationProvider)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let snippet = snippets[indexPath.section][indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.snippet = snippet
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func disconnect(_ sender: Any)
    {
        authenticationProvider.disconnect()
        self.navigationController?.splitViewController?.dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewController
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return snippets[section].name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return snippets.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return snippets[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let snippet = snippets[indexPath.section][indexPath.row]
        
        cell.textLabel!.text = snippet.name
        if snippet.needAdminAccess {
            cell.detailTextLabel!.text = "Need admin access"
        } else {
            cell.detailTextLabel!.text = ""
        }
        
        return cell
    }
}

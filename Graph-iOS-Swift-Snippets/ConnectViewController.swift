/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import UIKit

class ConnectViewController: UIViewController, UISplitViewControllerDelegate {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var connectButton: UIButton!
   
    let authentication: Authentication = Authentication()

    
    // MARK: - Split view
   
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.snippet == nil {
            // collapse when there is no snippet. i.e./ initial loading of the view controller.
            return true
        }
        return false
    }

    
    @IBAction func connectToGraph(sender: AnyObject) {
        authenticate()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSnippets" {
            let splitViewController = segue.destinationViewController as! UISplitViewController
            
            let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
            navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
            
            let navController = splitViewController.viewControllers.first as! UINavigationController
            print(navController)
            
            let masterViewController = navController.topViewController as! MasterViewController
            masterViewController.authentication = self.authentication
            
            splitViewController.delegate = self
            
        }
    }
}

// MARK: Authentication
private extension ConnectViewController {
    func authenticate() {
        loadingUI(show: true)
        
        let clientId = ApplicationConstants.clientId
        let scopes = ApplicationConstants.scopes
        
        authentication.connectToGraph(withClientId: clientId, scopes: scopes) {
            (error) in
            
            defer {self.loadingUI(show: false)}
            
            if let graphError = error {
                switch graphError {
                case .NSErrorType(let nsError):
                    print("Error:", nsError.localizedDescription)
                    self.showError(message: "Check print log for error details")
                case .UnexpectecError(let errorString):
                    print("Unexpected error:", errorString)
                    self.showError(message: "Check print log for error details")
                }
            }
            else {
                self.performSegueWithIdentifier("showSnippets", sender: nil)
            }
        }
    }
}


// MARK: UI Helper
private extension ConnectViewController {
    func loadingUI(show show: Bool) {
        if show {
            self.activityIndicator.startAnimating()
            self.connectButton.setTitle("Connecting...", forState: .Normal)
            self.connectButton.enabled = false;
        }
        else {
            self.activityIndicator.stopAnimating()
            self.connectButton.setTitle("Connect", forState: .Normal)
            self.connectButton.enabled = true;
        }
    }
    
    func showError(message message:String) {
        dispatch_async(dispatch_get_main_queue(),{
            let alertControl = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
            alertControl.addAction(UIAlertAction(title: "Close", style: .Default, handler: nil))
            
            self.presentViewController(alertControl, animated: true, completion: nil)
        })
    }
}




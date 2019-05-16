/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import UIKit
import MSAL

class ConnectViewController: UIViewController, UISplitViewControllerDelegate
{
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var connectButton: UIButton!
   
    let authenticationProvider: AuthenticationProvider? = {
        guard let authorityUrl = URL(string: ApplicationConstants.authority) else { return nil }
        
        var authenticationProvider: AuthenticationProvider?
        do {
            let authority = try MSALAADAuthority(url: authorityUrl)
            let clientId = ApplicationConstants.clientId
            authenticationProvider = try AuthenticationProvider(clientId: clientId, authority: authority)
        } catch let error as NSError {
            print("Error: ", error)
        }
        
        return authenticationProvider
    }()

    // MARK: - Split view
   
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool
    {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.snippet == nil {
            // collapse when there is no snippet. i.e./ initial loading of the view controller.
            return true
        }
        return false
    }

    
    @IBAction func connectToGraph(_ sender: Any)
    {
        authenticate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showSnippets" {
            let splitViewController = segue.destination as! UISplitViewController
            
            let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
            navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
            
            let navController = splitViewController.viewControllers.first as! UINavigationController
            print(navController)
            
            let masterViewController = navController.topViewController as! MasterViewController
            masterViewController.authenticationProvider = self.authenticationProvider
            
            splitViewController.delegate = self
        }
    }
    
    // MARK: - Private
    
    private func authenticate()
    {
        guard let authenticationProvider = self.authenticationProvider else { return }
        let scopes = ApplicationConstants.scopes
        
        showLoadingView(show: true)
        authenticationProvider.acquireAuthToken(scopes: scopes) { (success, error) in
            self.showLoadingView(show: false)
            
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.performSegue(withIdentifier: "showSnippets", sender: nil)
                }
                
                return;
            }
            
            print("Error: ", error?.description ?? "nil error")
            self.showError(message: "Check print log for error details")
        }
    }
    
    private func showLoadingView(show: Bool)
    {
        if show {
            activityIndicator.startAnimating()
            connectButton.setTitle("Connecting...", for: .normal)
            connectButton.isEnabled = false
        } else {
            activityIndicator.stopAnimating()
            connectButton.setTitle("Connect", for: .normal)
            connectButton.isEnabled = true
        }
    }
    
    func showError(message: String)
    {
        DispatchQueue.main.async {
            let alertControl = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertControl.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            
            self.present(alertControl, animated: true, completion: nil)
        }
    }
}

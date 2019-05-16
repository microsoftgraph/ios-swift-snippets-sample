/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var snippetNameLabel: UILabel!
    @IBOutlet var resultStackView: UIStackView!
    @IBOutlet var accessLevelLabel: UILabel!
    
    var snippet: Snippet?
    {
        didSet { configureView() }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        guard let _ = snippet else { return }
        
        executeSnippet()
    }
    
    // MARK: - Private
    
    private func executeSnippet()
    {
        guard let _ = snippet else { return }
        
        self.snippet!.execute { (result: Result) in
            switch result {
            case .Failure(let error):
                var displayText: String = "Failed\n\n"
                switch error {
                case .NSErrorType(let nsError):
                    displayText = nsError.localizedDescription
                    
                    for (key, value) in nsError.userInfo.enumerated() {
                        displayText += "\n\(key): \(value)"
                    }
                    
                    break
                case.UnexpectecError(let errorString):
                    displayText = errorString
                    break
                }
                
                DispatchQueue.main.async {
                    let result = UILabel()
                    result.numberOfLines = 0
                    result.text = displayText
                    
                    self.resultStackView.addArrangedSubview(result)
                    self.accessLevelLabel.removeFromSuperview()
                    
                    self.hideActivityIndicator()
                }
                
                break
            case .Success(let displayText):
                if let text = displayText {
                    DispatchQueue.main.async {
                        let result = UILabel()
                        result.numberOfLines = 0
                        result.text = "Success\n\n\(text)"
                        
                        self.resultStackView.addArrangedSubview(result)
                        self.hideActivityIndicator()
                    }
                }
                break
                
            case .SuccessDownloadImage(let displayImage):
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: displayImage)
                    
                    self.resultStackView.addArrangedSubview(imageView)
                    self.hideActivityIndicator()
                }
                break
            }
        }
    }
    
    private func hideActivityIndicator()
    {
        self.activityIndicatorView.stopAnimating()
        
        UIView.animate(withDuration: 0.35, animations: {
            self.activityIndicatorView.isHidden = true
        }) { (finished) in
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func configureView()
    {
        if let label = snippetNameLabel, let snippet = self.snippet {
            label.text = snippet.name
            accessLevelLabel.isHidden = !snippet.needAdminAccess
        }
    }
    
    func setResult(with string: String)
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = string
        
        resultStackView.addArrangedSubview(label)
    }
}


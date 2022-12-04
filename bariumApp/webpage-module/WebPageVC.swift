//
//  WebPageVC.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 26.11.2022.
//

import UIKit
import WebKit

class WebPageVC: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var firstLoadIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loadViewBlock: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.imdb.com/title/tt0903747/"
        if let url = URL(string: urlString){
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        }
            
    }
    
    func webView(_ webView: WKWebView, didFinish navigation:
     WKNavigation!) {
        firstLoadIndicator.stopAnimating()
        loadViewBlock.isHidden = true
 }

}

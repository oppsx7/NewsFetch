//
//  ArticleWebViewController.swift
//  NewsCoreML
//
//  Created by Todor Dimitrov on 20.10.21.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController {
    
    var article = Article()
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: article.url) {
            webView.load(URLRequest(url: url))
        }
    }

}

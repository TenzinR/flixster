//
//  TrailerViewController.swift
//  flixster
//
//  Created by Tenzin Rigchok on 9/19/21.
//

import UIKit
import WebKit
class TrailerViewController: UIViewController,WKUIDelegate {
    var movie : [String: Any]!
    var webView: WKWebView!
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let URLpart1 = "https://api.themoviedb.org/3/movie/"
        let id = movie["id"] as! String
        let URLpart2 = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let myURL = URL(string: URLpart1 + id + URLpart2)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



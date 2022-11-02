//
//  RXDocumentViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/16/22.
//

import UIKit
import WebKit

class RXDocumentViewController: UIViewController,WKNavigationDelegate {

    var webView : WKWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.webView!.navigationDelegate = self
        let url = URL(string: "https://beeth0ven.github.io/RxSwift-Chinese-Documentation/")
        let req = URLRequest(url: url!)
        self.webView!.load(req)
        self.view.addSubview(self.webView!)
        self.webView!.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        
        self.progressView.frame = CGRect(x: 0 , y: kNavigationBarH, width: screenWidth , height: 2)
        progressView.progressTintColor = UIColor.red
        progressView.trackTintColor = UIColor.clear
        self.view.addSubview(self.progressView)
    }
    
    lazy var progressView : UIProgressView = {
        let progress = UIProgressView.init()
        progress.progress = 0.05
        return progress
    }()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
            //  加载进度条
                if keyPath == "estimatedProgress"{
                    progressView.alpha = 1.0
                    progressView.setProgress(Float((self.webView?.estimatedProgress) ?? 0), animated: true)
                    if (self.webView?.estimatedProgress ?? 0.0)  >= 1.0 {
                        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                            self.progressView.alpha = 0
                        }, completion: { (finish) in
                            self.progressView.setProgress(0.0, animated: false)
                        })
                    }
                }
            }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressView.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

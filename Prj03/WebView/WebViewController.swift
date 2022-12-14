//
//  WebViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/22.
//

import Foundation
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    //
    @IBOutlet var naviView: UIView!
    @IBOutlet var outterview: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    //
    var transitionDuration : Double = 0.2
    var transition : ScrollAnimation = .downScrolling
    private var scrollStartAt: CGFloat? = 0
    
    //ボタンに使うイメージ
    let backImage : UIImage = UIImage(systemName: "chevron.backward")!
    let forwardImage : UIImage  = UIImage(systemName: "chevron.forward")!
    let relaodImage : UIImage  = UIImage(systemName: "arrow.clockwise")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://gngs.co.jp/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
        backButton.setImage(backImage, for: .normal)
        forwardButton.setImage(forwardImage, for: .normal)
        refreshButton.setImage(relaodImage, for: .normal)
        
        backButton.tintColor =
        (webView.canGoBack ? UIColor.systemBlue : UIColor.gray)
        
        forwardButton.tintColor =
        (webView.canGoForward ? UIColor.systemBlue : UIColor.gray)
        
        refreshButton.tintColor = UIColor.systemBlue
        
        
        //webView
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        
        //
        self.webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        
//        backButton.isEnabled = false
//        forwardButton.isEnabled = false
        
    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.webView.translatesAutoresizingMaskIntoConstraints  = false
        [
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.naviView.bottomAnchor),
        ].forEach{ $0.isActive = true }
    }
    
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(true)
    //    }
    
    
    
    @IBAction func backAct(_ sender: Any) {
        if(self.webView.canGoBack){
            self.webView.goBack()
        }
        
//        self.webView.reload()
        
    }
    
    
    @IBAction func forwardAct(_ sender: Any) {
        if(self.webView.canGoForward){
            self.webView.goForward()
            
        }
        
//        self.webView.reload()
        
    }
    
    @IBAction func refreshAct(_ sender: Any) {
        self.webView.reload()
    }
    
    
    
    //
    func updateNaviTollbarPosition(isTabHidden flag:Bool) {
        let y: CGFloat = self.view.frame.maxY - self.naviView.frame.height - (flag ? 10 : (self.tabBarController?.tabBar.frame.height) ?? 0)
        
        self.naviView.frame = CGRect(x: 0, y: y+50, width: self.view.frame.width, height: self.naviView.frame.height)
    }
    
    
}

enum ScrollAnimation{
    case upScrolling
    case downScrolling
}

var beforeHashURL:String = ""

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

//MARK: --Delegate
extension WebViewController : WKNavigationDelegate,UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollStartAt = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let prevY : CGFloat = self.scrollStartAt else {return}
        let currY = scrollView.contentOffset.y
        let scrollToUp = currY <= prevY
        
        if scrollToUp{
            self.tabBarController?.tabBar.isHidden  = false
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tabBarController?.tabBar.alpha = scrollToUp ? 1 : 0
            self.updateNaviTollbarPosition(isTabHidden: !scrollToUp)
        }, completion: { _ in
            self.tabBarController?.tabBar.isHidden = !scrollToUp
        })
        
    }
    
    
    
    //webView delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        //活性化、非活性化
        
        if(webView.canGoBack){
            backButton.isEnabled = true
            backButton.tintColor = UIColor.systemBlue
        }else{
            backButton.isEnabled = false
            backButton.tintColor = UIColor.gray
        }
        
//        backButton.tintColor =
//        (webView.canGoBack ? UIColor.blue : UIColor.gray)
        
        
        if(webView.canGoForward){
            forwardButton.isEnabled = true
            forwardButton.tintColor = UIColor.systemBlue
        }else{
            forwardButton.isEnabled = false
            forwardButton.tintColor = UIColor.gray
        }
        
//        forwardButton.tintColor =
//        (webView.canGoForward ? UIColor.blue : UIColor.gray)
        
        
    }
    
    
    
    //URL TRACKing
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            guard let url = self.webView.url?.absoluteString else {
                return
            }
            
            print(url)

            if(url == "https://gngs.co.jp/" && beforeHashURL == "1"){
                print("beforeHashURL「1」 && 「#」")
                beforeHashURL = ""
                self.webView.reload()
                return
            }
            
            if(url.contains("results")){
                beforeHashURL = ""
                return
            }
            
            if(url.contains("#")){
                print("URLに「#」が入っています。ページをreloadします。")
                self.webView.reload()
                
                beforeHashURL = "1"
            }
            
        }
    }
    
}




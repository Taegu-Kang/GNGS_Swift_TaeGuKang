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
        (webView.canGoBack ? UIColor.blue : UIColor.gray)
        
        forwardButton.tintColor =
        (webView.canGoForward ? UIColor.blue : UIColor.gray)
        
        
        //webView
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
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
        
        
        if(self.webView.canGoForward){
            forwardButton.tintColor = UIColor.blue
        }else{
            forwardButton.tintColor = UIColor.gray
        }
        
        if(self.webView.canGoBack){
            backButton.tintColor = UIColor.blue
        }else{
            backButton.tintColor = UIColor.gray
        }
    }
    
    
    @IBAction func forwardAct(_ sender: Any) {
        if(self.webView.canGoForward){
            self.webView.goForward()
            
        }
        
        
        if(self.webView.canGoForward){
            forwardButton.tintColor = UIColor.blue
        }else{
            forwardButton.tintColor = UIColor.gray
        }
        
        if(self.webView.canGoBack){
            backButton.tintColor = UIColor.blue
        }else{
            backButton.tintColor = UIColor.gray
        }
        
        
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
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        backButton.tintColor =
        (webView.canGoBack ? UIColor.blue : UIColor.gray)
        
        
        forwardButton.tintColor =
        (webView.canGoForward ? UIColor.blue : UIColor.gray)
    }
    
}




//
//  WebViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/22.
//

import Foundation
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webKit: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    //ボタンに使うイメージ
    let backImage : UIImage = UIImage(systemName: "chevron.backward")!
    let forwardImage : UIImage  = UIImage(systemName: "chevron.forward")!
    let relaodImage : UIImage  = UIImage(systemName: "arrow.clockwise")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://gngs.co.jp/")
        let request = URLRequest(url: url!)
        webKit.load(request)
        
        backButton.setImage(backImage, for: .normal)
        forwardButton.setImage(forwardImage, for: .normal)
        refreshButton.setImage(relaodImage, for: .normal)
        
    }
    
    @IBAction func backAct(_ sender: Any) {
        if(self.webKit.canGoBack){
            self.webKit.goBack()
        }
    }
    @IBAction func forwardAct(_ sender: Any) {
        if(self.webKit.canGoForward){
            self.webKit.goForward()
        }
    }
    @IBAction func refreshAct(_ sender: Any) {
        self.webKit.reload()
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



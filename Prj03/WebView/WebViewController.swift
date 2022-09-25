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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://gngs.co.jp/")
        let request = URLRequest(url: url!)
        webKit.load(request)
    
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



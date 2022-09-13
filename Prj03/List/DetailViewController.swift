//
//  DetailViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toTableButtonAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true ) 
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

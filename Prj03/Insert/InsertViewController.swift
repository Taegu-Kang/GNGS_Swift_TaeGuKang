//
//  InsertViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/14.
//

import UIKit
import Foundation


class InsertViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw1: UITextField!
    @IBOutlet weak var pw2: UITextField!
    
    
    @IBOutlet weak var syokuTextField: UITextField!
    
    let syokuArr = ["1","12","123","1234","12345","123456"]
    var syokuPickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: formView.frame.width, height: formView.frame.height)
        
        syokuTextField.inputView = syokuPickerView
        
        syokuPickerView.delegate = self
        syokuPickerView.dataSource = self
        
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

extension InsertViewController: UIPickerViewDataSource, UIPickerViewDelegate {



    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return syokuArr.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return syokuArr[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }

}

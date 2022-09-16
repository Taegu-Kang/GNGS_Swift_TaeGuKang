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
    
    //
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw1: UITextField!
    @IBOutlet weak var pw2: UITextField!
    
    //validation check 項目
    var flag1 : Bool = false
    var flag2 : Bool = false
    var flag3 : Bool = false
    var flag4 : Bool = false
    
    
    //checkBox
    @IBOutlet weak var checkBox: UIButton!
    let noneCheckImage = UIImage(systemName: "square")
    let checkImage = UIImage(systemName: "checkmark.square.fill")
    var checkBoxBool : Bool = true
    
    //PickerView
    @IBOutlet weak var syokuTextField: UITextField!
    let syokuArr = ["学生","社会人","主婦","公務員","その他"]
    var syokuPickerView = UIPickerView()
    
    //radioButton
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: formView.frame.width, height: formView.frame.height)
        
        syokuTextField.inputView = syokuPickerView
        
        syokuTextField.tintColor = .clear
        syokuTextField.textAlignment = .center
        
        syokuPickerView.delegate = self
        syokuPickerView.dataSource = self
        
        //checkBox default値
        checkBox.isSelected = true
        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)

        
    }
    
    
    //checkBox Toggle
    @IBAction func checkBoxAction(_ sender: UIButton) {
        checkBox.isSelected.toggle()
        checkBoxBool.toggle()
        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)
        
        print(checkBoxBool)
    }
    
    
    //Validation func1
    
    //Validation func2
    
    //Validation func3
    
    //Validation func4
    
    
    //登録ボタン　action　, validation_func check : error message 表示（ポップオップ）
    @IBAction func signUpButton(_ sender: UIButton) {
        
        //func1
        
        //func2
        
        //func3
        
        //func4
        
        //flag check func()
        
    }
    
    // flag check func _ flag 1,2,3,4 check -> OK -> 登録完了、確認画面に遷移
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


//UIPickerView 関連 (職業選ぶ)
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
        syokuTextField.text = syokuArr[row]
        syokuTextField.resignFirstResponder()
        //syokuTextField.isUserInteractionEnabled = false
    }

}

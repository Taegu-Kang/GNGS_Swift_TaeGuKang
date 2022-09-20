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
    var idValiFlag : Bool = false
    var pwValiFlag : Bool = false
    var yakkannCheckFlag : Bool = false
    
    //checkBox
    @IBOutlet weak var checkBox: UIButton!
    let noneCheckImage = UIImage(systemName: "square")
    let checkImage = UIImage(systemName: "checkmark.square.fill")
    var checkBoxBool : Bool = false
    
    //radioButton
     //Male
    @IBOutlet weak var maleRadio: UIButton!
    let noneChkMale = UIImage(systemName: "circle")
    let ChkMale = UIImage(systemName: "circle.inset.filled")
    var maleBool : Bool = true
     //Female
    @IBOutlet weak var femaleRadio: UIButton!
    let noneChkFemale = UIImage(systemName: "circle")
    let ChkFemale = UIImage(systemName: "circle.inset.filled")
    var femaleBool : Bool = false
    
    //PickerView
    @IBOutlet weak var syokuTextField: UITextField!
    let syokuArr = ["学生","社会人","主婦","公務員","その他"]
    var syokuPickerView = UIPickerView()
    
    //alert
    var alert : UIAlertController = UIAlertController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: formView.frame.width, height: formView.frame.height)
        
        syokuTextField.inputView = syokuPickerView
        
        syokuTextField.tintColor = .clear
        syokuTextField.textAlignment = .center
        
        syokuPickerView.delegate = self
        syokuPickerView.dataSource = self
        
        //checkBox default値
        checkBox.isSelected = false
        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)
        
        //性別radio button default値
        maleRadio.isSelected = true
        maleRadio.setImage(maleRadio.isSelected ? ChkMale : noneChkMale, for: .normal)
        femaleRadio.isSelected = false
        femaleRadio.setImage(femaleRadio.isSelected ? ChkFemale : noneChkFemale, for: .normal)
        
    }
    
    //checkBox Toggle
    @IBAction func checkBoxAction(_ sender: UIButton) {
        checkBox.isSelected.toggle()
        checkBoxBool.toggle()
        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)
        
        print("checkBoxBool :" , checkBoxBool)
    }
    
    
    //radioButton Toggle
        //male Button
    @IBAction func maleRadioAction(_ sender: Any) {
        maleRadio.isSelected = true
        femaleRadio.isSelected = false
        maleBool.toggle()
        femaleBool.toggle()
        maleRadio.setImage(maleRadio.isSelected ? ChkMale : noneChkMale, for: .normal)
        femaleRadio.setImage(femaleRadio.isSelected ? ChkFemale : noneChkFemale, for: .normal)
    }
        //female Button
    @IBAction func femaleRadioAction(_ sender: Any) {
        femaleRadio.isSelected = true
        maleRadio.isSelected = false
        femaleBool.toggle()
        maleBool.toggle()
        femaleRadio.setImage(femaleRadio.isSelected ? ChkFemale : noneChkFemale, for: .normal)
        maleRadio.setImage(maleRadio.isSelected ? ChkMale : noneChkMale, for: .normal)
    }
    
    
    //Validation func1 ( ID )
    func idValidation() -> Bool {
        //空白チェック
        if id.text!.isEmpty, id.text! == "" {
            alert = UIAlertController(title: "IDを入力してください。", message: "IDが空いております。\n 入力してください。", preferredStyle: UIAlertController.Style.alert)
            
            let idAlertAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default, handler: { _ in
                self.id.becomeFirstResponder()
            })
            
            alert.addAction(idAlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        //正規化チェック
        if id.text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z]+.[A-Za-z]", options: .regularExpression) == nil{
           
            alert = UIAlertController(title: "メールアドレスを入力してください。", message: "IDはメールアドレスです。", preferredStyle: UIAlertController.Style.alert)
            
            let idAlertAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default, handler: { _ in
                self.id.becomeFirstResponder()
            })
            
            alert.addAction(idAlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            
           return false
        }
        //pass
        return true
    }
    
    
    //Validation func2 ( pw1, pw2 )
    func pwValidation() -> Bool {
        //空白チェック pw1
        if pw1.text!.isEmpty, pw1.text! == "" {
            alert = UIAlertController(title: "パスワードを入力してください。", message: "パスワードが空いております。\n 入力してください。", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default, handler: { _ in
                self.pw1.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
            
        }
        //正規化チェック pw1
        if pw1.text!.range(of: "^.*(?=^.{8,15}$)(?=.*[0-9])(?=.*[a-zA-Z]).*$", options: .regularExpression) == nil{
            alert = UIAlertController(title: "パスワードは小文字、大文字、数字を混ぜて８桁以上になります。", message: "パスワードは小文字、大文字、数字を混ぜて８桁以上になります。", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default, handler: { _ in
                self.pw1.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        //空白チェック pw2
        if pw2.text!.isEmpty, pw2.text! == "" {
            alert = UIAlertController(title: "パスワード(再入力)を入力してください。", message: "パスワード(再入力)が空いております。\n 入力してください。", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default, handler: { _ in
                self.pw2.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        //pw1,pw2 一致性チェック
        if pw1.text! != pw2.text! {
            alert = UIAlertController(title: "パスワード(再入力)とパスワードが一致しません。", message: "パスワード(再入力)とパスワードが一致しません。", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default, handler: { _ in
                self.pw2.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    //Validation func3 ( 約款Check　)
    func yakkannCheck() -> Bool {
        //約款checkBoxBool チェック
        if checkBoxBool {
            alert = UIAlertController(title: "約款に同意してください。", message: "約款に同意してください。", preferredStyle: UIAlertController.Style.alert)
            
            let yakkannAlertAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default, handler: { _ in
                self.checkBox.becomeFirstResponder()
            })
            
            alert.addAction(yakkannAlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    //登録ボタン　action　, validation_func check : vali_flag, error message 表示
    @IBAction func signUpButton(_ sender: UIButton) {
        
        
        //vali func1
        idValiFlag = idValidation()
        
        //vali func2
        pwValiFlag = pwValidation()
        
        //vali func3
        yakkannCheckFlag = yakkannCheck()
        
        
        //f1,f2,f3 = All valiFlag check
        print("id Flag : ",  idValiFlag)
        print("pw Flag : ",  pwValiFlag)
        print("yakkann Flag : ",  yakkannCheckFlag)
        
        if(idValiFlag && pwValiFlag && yakkannCheckFlag ){
            print("All PASS")
        }
        
        
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

//
//  InsertViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/14.
//

import UIKit
import Foundation


class InsertViewController: UIViewController {
    
    var insertValue : InsertValue = InsertValue()
    
    //scroll 関連
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var formView: UIView!
    
    //member 変
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw1: UITextField!
    @IBOutlet weak var pw2: UITextField!
    
    @IBOutlet weak var memo: UITextView!
    
    //uiSwitch メールマガジン
    @IBOutlet weak var uiSwitch: UISwitch!
    var switchBool : Bool = true
    
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
    let syokuArr = ["平社員","主任","課長","部長","次長","代表"]
    var syokuPickerView = UIPickerView()
    
    //alert
    var alert : UIAlertController = UIAlertController()
    
    //
    var selectingText : String = ""
    var selectedPickerText : String = ""
    
    //keyBoard
    //var keyHeight : CGFloat?
    
    @IBOutlet weak var innerView: UIView!
    
    @IBAction func pickerAction(_ sender: Any) {
        //.inputView したい
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scroll
        scrollView.contentSize = CGSize(width: formView.frame.width, height: formView.frame.height)
        
        //pickerView
        syokuTextField.text = "平社員"
        syokuTextField.tintColor = .clear
        syokuTextField.textAlignment = .center
        
        syokuTextField.inputView = syokuPickerView
        
//        syokuPickerView.delegate = self
//        syokuPickerView.dataSource = self
        
        createPickerView()
        dismissPickerView()
        
        //checkBox default値
        checkBox.isSelected = false
        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)
        
        //性別radio button default値
        maleRadio.isSelected = true
        maleRadio.setImage(maleRadio.isSelected ? ChkMale : noneChkMale, for: .normal)
        femaleRadio.isSelected = false
        femaleRadio.setImage(femaleRadio.isSelected ? ChkFemale : noneChkFemale, for: .normal)
        
        //入力制限 delegate
        id.delegate = self
        pw1.delegate = self
        pw2.delegate = self
        
        //keyboard type
        id.keyboardType = .emailAddress
        pw1.keyboardType = .asciiCapable
        pw2.keyboardType = .asciiCapable
        
        //keyboard down
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        
        //keyboard up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    //
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
            
        
//        if !memo.isFirstResponder {
//            return
//        }
//
//        if self.view.frame.origin.y == 0 {
//            if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
//                self.view.frame.origin.y -= (keyboardRect - 50)
//
//            }
//        }
        
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.scrollView.contentSize = CGSize(
            width: self.scrollView.frame.width,
            height: 750 + keyboardFrame
        )
        
        if self.memo.isFirstResponder {
            // 一番下に移動
            let y = self.innerView.frame.height - self.scrollView.frame.height + 20 + keyboardFrame
            self.scrollView.contentOffset = CGPoint(x: 0, y: y)
        }
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        /*if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }*/
        
        self.scrollView.contentSize = CGSize(
            width: self.scrollView.frame.width,
            height: 900
        )
    }
    
    //keyboard _ return key // 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    //switch Toggle
    @IBAction func switchAction(_ sender: Any) {
        switchBool.toggle()
        print("switch Bool :", switchBool)
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
            alert = UIAlertController(title: "IDを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let idAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.id.becomeFirstResponder()
            })
            
            alert.addAction(idAlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        //正規化チェック
        //[0-9a-z._%+-]+@[a-z]+.[a-z]
        //
        if id.text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .regularExpression) == nil{
           
            alert = UIAlertController(title: "IDはメールアドレスです。\nメールアドレスを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let idAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
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
            alert = UIAlertController(title: "パスワードを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw1.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
            
        }
        //正規化チェック pw1
        if pw1.text!.range(of: "^.*(?=^.{8,15}$)(?=.*[0-9])(?=.*[a-zA-Z]).*$", options: .regularExpression) == nil{
            alert = UIAlertController(title: "パスワードは英文字、\n数字を混ぜて８桁以上になります。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw1.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        //空白チェック pw2
        if pw2.text!.isEmpty, pw2.text! == "" {
            alert = UIAlertController(title: "パスワード(再入力)を入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw2.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        //pw1,pw2 一致性チェック
        if pw1.text! != pw2.text! {
            alert = UIAlertController(title: "パスワード(再入力)とパスワードが一致しません。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw2.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        //pass
        return true
    }
    
    //Validation func3 ( 約款Check　)
    func yakkannCheck() -> Bool {
        //約款checkBoxBool チェック
        if !checkBoxBool {
            alert = UIAlertController(title: "約款に同意してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let yakkannAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.checkBox.becomeFirstResponder()
            })
            
            alert.addAction(yakkannAlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        //pass
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
            //入力したデータ
            insertValue = InsertValue(id: id.text!, syoku: syokuTextField.text!,
            gender: maleBool, mail_magazine: switchBool, yakkann: true, memo: memo.text!)
            
            print(memo.text!)
            
            //flag check func _ flag 1,2,3 check -> OK -> 登録完了、確認画面に移動
            self.performSegue(withIdentifier: "showInsertMember", sender: nil)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInsertMember" {
            guard let destination = segue.destination as? Detail_InsertViewController else {
                fatalError("Failed to prepare DetailViewController.")

            }
                //data tennsou
            destination.insertValue = self.insertValue
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
    
    
    //pickerView button_ done　決定
    @objc func done(_ sender : UIBarButtonItem) {
        self.syokuTextField.text! =  selectingText
        selectedPickerText = self.syokuTextField.text!
        self.syokuTextField.endEditing(true)
    }
    //pickerView button_ cancel 取り消し
    @objc func cancel() {
        //window 閉める
        syokuTextField.resignFirstResponder()
        //textField 削除
//      self.syokuTextField.text! = ""
        self.syokuTextField.endEditing(true)
        //        pickerView.selectRow(selectArrayRow, inComponent: 0, animated: true)
    }
    
    
}


//UIPickerView 関連 (職業選ぶ)
extension InsertViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

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
        
//        syokuTextField.text = syokuArr[row]
        selectingText = syokuArr[row]
//        syokuTextField.resignFirstResponder()
        //syokuTextField.isUserInteractionEnabled = false
    }
    
    func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        syokuTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button1 = UIBarButtonItem(title: "決定", style: .plain, target: self, action: #selector(self.done))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let button2 = UIBarButtonItem(title: "キャンサル", style: .plain, target: self, action: #selector(self.cancel))
        toolBar.setItems([button2, space, button1], animated: true)
    
        toolBar.isUserInteractionEnabled = true
        syokuTextField.inputAccessoryView = toolBar
    }
    
    
    //入力制限　関連
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        
        let currStr = textField.text! as NSString
        let changed = currStr.replacingCharacters(in: range, with: string)
        
        
        let invalid  : NSCharacterSet = NSCharacterSet(charactersIn:  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-").inverted as NSCharacterSet
        let range = string.rangeOfCharacter(from: invalid as CharacterSet)
        
        
        //backSpace 可能化
//        if let char = string.cString(using: String.Encoding.utf8) {
//             let isBackSpace = strcmp(char, "\\b")
//             if isBackSpace == -92 {
//                 return true
//             }
//         }
        
        if textField == id {
            //id
            guard range == nil else { return false }
            guard changed.count < 50 else { return false }
            return true
        } else {
            //pw1, pw2
            
            //guard textField.text!.count < 15 else { return false }
            guard changed.count < 15 else { return false }
            return true
        }
        
        
    }
    

}






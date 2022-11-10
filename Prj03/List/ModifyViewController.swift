//
//  InsertViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/14.
//

import UIKit
import Foundation


class ModifyViewController: UIViewController {
    
    var insertValue : InsertValue = InsertValue()
    
    var row:Int = 0
    
    //DB
    var database = Database()
    //
    var dbArr: [User] = []
    //
    var user:User = User(USER_NUM: "", USER_ID: "", USER_PASS: "", NAME_KZ: "", NAME_KANA: "", NAME_ENG: "", TELL: "", GENDER: 1, POSITION: 1, TEAM: 1, MAGAZINE: 1, MEMO: "", INSERT_DATE: "")
    
    
    //scroll 関連
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var formView: UIView!
    
    //member 変
    @IBOutlet weak var user_num: UITextField!
    @IBOutlet weak var user_id: UITextField!
    
    @IBOutlet weak var name_kz: UITextField!
    @IBOutlet weak var name_kana: UITextField!
    @IBOutlet weak var name_eng: UITextField!
    
    @IBOutlet weak var memo: UITextView!
    
    //Tel
    @IBOutlet weak var tel1: UITextField!
    @IBOutlet weak var tel2: UITextField!
    @IBOutlet weak var tel3: UITextField!
    var telArr: [String] = []
    
    //uiSwitch メールマガジン
    @IBOutlet weak var uiSwitch: UISwitch!
    var switchBool : Bool = true
    
    //validation check 項目
    var telValiFlag : Bool = false
    var nameValFlag : Bool = false
    //var yakkannCheckFlag : Bool = false
    
    //checkBox
//    @IBOutlet weak var checkBox: UIButton!
//    let noneCheckImage = UIImage(systemName: "square")
//    let checkImage = UIImage(systemName: "checkmark.square.fill")
//    var checkBoxBool : Bool = false
    
    //Gender_radioButton
    //Male
    var maleBool : Bool = true
    @IBOutlet weak var maleRadio: UIButton!
    let noneChkMale = UIImage(systemName: "circle")
    let ChkMale = UIImage(systemName: "circle.inset.filled")
    //Female
    var femaleBool : Bool = false
    @IBOutlet weak var femaleRadio: UIButton!
    let noneChkFemale = UIImage(systemName: "circle")
    let ChkFemale = UIImage(systemName: "circle.inset.filled")
    
    
    //PickerView
    @IBOutlet weak var syokuTextField: UITextField!
    let syokuArr = ["平社員","主任","課長","部長","次長","代表"]
    var syokuPickerView = UIPickerView()
    
    //PickerView2
    @IBOutlet weak var syozokuTextField: UITextField!
    let syozokuArr = ["第１チーム","第２チーム","第３チーム","第４チーム","第５チーム","第６チーム"]
    var syozokuPickerView = UIPickerView()
    
    //backButton
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        
        
    }
    
    
    
    
    //alert
    var alert : UIAlertController = UIAlertController()
    
    //
    var selectingText : String = ""
    var selectingText2 : String = ""
    var selectedPickerText : String = ""
    var selectedPickerText2 : String = ""
    
    //keyBoard
    //var keyHeight : CGFloat?
    
    @IBOutlet weak var innerView: UIView!
    
    @IBAction func pickerAction(_ sender: Any) {
        //.inputView したい
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        print(row)
        
        print(user.USER_NUM)
        
        print(user.GENDER)
        
        user_num.text = user.USER_NUM
        user_id.text = user.USER_ID
        
        name_kz.text = user.NAME_KZ
        name_kana.text = user.NAME_KANA
        
        name_eng.text = user.NAME_ENG
        
        memo.text = user.MEMO
        
        //Tel
        seperTel()
        
        tel1.text = telArr[0]
        tel2.text = telArr[1]
        tel3.text = telArr[2]
        
        //
        database.openDB()

        
        //scroll
        scrollView.contentSize = CGSize(width: formView.frame.width, height: formView.frame.height)
        
        //pickerView1 役職
        var posi:String = ""
         switch user.POSITION {
         case 1:
             posi = "平社員"
         case 2:
             posi = "主任"
         case 3:
             posi = "課長"
         case 4:
             posi = "部長"
         case 5:
             posi = "次長"
         case 6:
             posi = "代表"
         default:
             posi = "平社員"
         }
        syokuTextField.text = posi
        selectingText = posi
        
        selectedPickerText = posi
        
        //pickerView1 所属
        
        var zoku:String = ""
        switch user.TEAM {
         case 1:
             zoku = syozokuArr[0]
         case 2:
             zoku = syozokuArr[1]
         case 3:
             zoku = syozokuArr[2]
         case 4:
             zoku = syozokuArr[3]
         case 5:
             zoku = syozokuArr[4]
         case 6:
             zoku = syozokuArr[5]
         default:
             zoku = syozokuArr[0]
         }
        syozokuTextField.text = zoku
        selectingText2 = zoku
        
        selectedPickerText2 = zoku
        
        
        //magazine
//        if(user.MAGAZINE == 0){ switchBool = false }
            
        
        syokuTextField.tintColor = .clear
        syokuTextField.textAlignment = .center
        
        syokuTextField.inputView = syokuPickerView
        
//        syokuPickerView.delegate = self
//        syokuPickerView.dataSource = self
        
        createPickerView()
        dismissPickerView()
        
        //checkBox default値
//        checkBox.isSelected = false
//        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)
        
        //性別radio button default値
        maleRadio.isSelected = true
        maleRadio.setImage(maleRadio.isSelected ? ChkMale : noneChkMale, for: .normal)
        femaleRadio.isSelected = false
        femaleRadio.setImage(femaleRadio.isSelected ? ChkFemale : noneChkFemale, for: .normal)
        
        //Gender
        gender()
//        //mail magazine
        mgz()
        
        print("didLoad -> switch Bool :", switchBool)
        
        //入力制限 delegate
     //user_id.delegate = self
        
        name_kz.delegate = self
        name_kana.delegate = self
        name_eng.delegate = self
        
        //keyboard type
        user_id.keyboardType = .emailAddress
//        name_kz.keyboardType = .asciiCapable
//          name_eng.keyboardType = .asciiCapable
        
        //keyboard down
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        
        //keyboard up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //Gender
    func gender(){
        if(user.GENDER == 0){
            maleBool = false
            femaleBool = true
            
            maleRadio.isSelected = false
            maleRadio.setImage(maleRadio.isSelected ? ChkMale : noneChkMale, for: .normal)
            femaleRadio.isSelected = true
            femaleRadio.setImage(femaleRadio.isSelected ? ChkFemale : noneChkFemale, for: .normal)
        }
    }
    
    //Gender
    func mgz(){
        print("mgz_modify:",user.MAGAZINE)
        if(user.MAGAZINE == 0){
            //switchBool = false
            switchBool.toggle()
//            uiSwitch.offImage
            print(switchBool)
        }
    }
    
    
    
    //tel seperated
    func seperTel() {
        //func for csvArr[].seperated -> dataArr[].append
        telArr = user.TELL.description.components(separatedBy: "-")
        
        print("telArr.count:",telArr.count)
        
        while(telArr.count < 3 ){
            telArr.append("")
        }
        
        
    }
        
        
    //MARK: KeyBoard POPUP
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
            let y = self.innerView.frame.height - self.scrollView.frame.height + (-90) + keyboardFrame
            self.scrollView.contentOffset = CGPoint(x: 0, y: y)
        }
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        /*if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }*/
        
        self.scrollView.contentSize = CGSize(
            width: self.scrollView.frame.width,
            height: 1100
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
//    @IBAction func checkBoxAction(_ sender: UIButton) {
//        checkBox.isSelected.toggle()
//        checkBoxBool.toggle()
//        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)
//        
//        print("checkBoxBool :" , checkBoxBool)
//    }
    
    
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
    func idVali() -> Bool {
        //空白チェック
        if user_id.text!.isEmpty, user_id.text! == "" {
            alert = UIAlertController(title: "IDを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let idAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.user_id.becomeFirstResponder()
            })
            
            alert.addAction(idAlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        //正規化チェック
        //[0-9a-z._%+-]+@[a-z]+.[a-z]
        //
        if user_id.text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .regularExpression) == nil{
           
            alert = UIAlertController(title: "IDはメールアドレスです。\nメールアドレスを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let idAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.user_id.becomeFirstResponder()
            })
            
            alert.addAction(idAlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            
           return false
        }
        //pass
        return true
    }
    
    
    //Validation func2 ( pw1, pw2 )
    func nameVali() -> Bool {
        //空白チェック pw1
        if name_kz.text!.isEmpty, name_kz.text! == "" {
            alert = UIAlertController(title: "名前(漢字)を入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.name_kz.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
            
        }

        //空白チェック pw2
        if name_kana.text!.isEmpty, name_kana.text! == "" {
            alert = UIAlertController(title: "名前(カナ)を入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.name_kana.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        //pw1,pw2 一致性チェック
        if name_eng.text!.isEmpty, name_eng.text! == "" {
            alert = UIAlertController(title: "名前(英語)を入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.name_eng.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        //pass
        return true
    }
    
    //Validation func2 ( pw1, pw2 )
    func telVali() -> Bool {
        //空白チェック pw1
        if tel1.text!.isEmpty, tel1.text! == "" {
            alert = UIAlertController(title: "電話番号を入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.tel1.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
            
        }

        //空白チェック pw2
        if tel2.text!.isEmpty, tel2.text! == "" {
            alert = UIAlertController(title: "電話番号を入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.tel1.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        //pw1,pw2 一致性チェック
        if tel3.text!.isEmpty, tel3.text! == "" {
            alert = UIAlertController(title: "電話番号を入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw2AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.tel3.becomeFirstResponder()
            })
            
            alert.addAction(pw2AlertAction)
            
            self.present(alert, animated: true, completion: nil)
            return false
        }
        //pass
        return true
    }
    
    
    //Validation func3 ( 約款Check　)
//    func yakkannCheck() -> Bool {
//        //約款checkBoxBool チェック
//        if !checkBoxBool {
//            alert = UIAlertController(title: "約款に同意してください。", message: "", preferredStyle: UIAlertController.Style.alert)
//
//            let yakkannAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
//                self.checkBox.becomeFirstResponder()
//            })
//
//            alert.addAction(yakkannAlertAction)
//
//            self.present(alert, animated: true, completion: nil)
//            return false
//        }
//        //pass
//        return true
//    }
    
    
    //登録ボタン　action　, validation_func check : vali_flag, error message 表示
    @IBAction func signUpButton(_ sender: UIButton) {
        
        //vali func1
        telValiFlag = telVali()
        
        //vali func2
        nameValFlag = nameVali()
        
        //vali func3
        //yakkannCheckFlag = yakkannCheck()
        
        //f1,f2,f3 = All valiFlag check
        print("name Flag : ", telValiFlag)
        print("tel Flag : ",  nameValFlag)
        //print("yakkann Flag : ",  yakkannCheckFlag)
        
        if(telValiFlag && nameValFlag ){
            print("All PASS")
            //入力したデータ
//            insertValue = InsertValue(id: user_id.text!, syoku: syokuTextField.text!,
//            gender: maleBool, mail_magazine: switchBool, yakkann: true, memo: memo.text!)
            
            print(memo.text!)
            print(syokuTextField.text!)
            
            
            let tel:String = tel1.text! + "-" + tel2.text! + "-" + tel3.text!
            var gen:Int8 = 7
            if(maleBool){ gen = 1 }else{ gen = 0 }
            
            //POSITION
            var posi:Int8 = 111
            for num in 0...syokuArr.count-1{
//                print("----------------")
//                print(syokuTextField.text!)
//                print(syokuArr[num])
                if(syokuTextField.text! == syokuArr[num]){
                    print("posi",posi)
                    print("num",num)
                    posi = Int8(num) + 1
                    break
                }
            }
            //TEAM
            var team:Int8 = 111
            for num in 0...syozokuArr.count-1{
                print("----------------")
                print(syozokuTextField.text!)
                print(syozokuArr[num])
                if(syozokuTextField.text! == syozokuArr[num]){
                    print("team",team)
                    print("num",num)
                    team = Int8(num) + 1
                    break
                }
            }
            var mgz:Int8 = 7
            if(switchBool){ mgz = 1 }else{ mgz = 0 }
            
            //User Object 準備
            let user:User = User(USER_NUM: user_num.text!, USER_ID: "", USER_PASS: "", NAME_KZ: name_kz.text!, NAME_KANA: name_kana.text!, NAME_ENG: name_eng.text!, TELL: tel, GENDER: gen, POSITION: posi, TEAM: team, MAGAZINE: mgz, MEMO: memo.text!, INSERT_DATE: "")
            
            database.update(user: user)
            
            self.presentingViewController?.dismiss(animated: true)
            //refresh(?)
            
            
            
            
            
            //flag check func _ flag 1,2,3 check -> OK -> 登録完了、確認画面に移動
//            self.performSegue(withIdentifier: "showInsertMember", sender: nil)
        }
    }
    
    
    // segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showInsertMember" {
//            guard let destination = segue.destination as? Detail_InsertViewController else {
//                fatalError("Failed to prepare DetailViewController.")
//
//            }
//                //data tennsou
////            destination.insertValue = self.insertValue
//            print("data tennsou")
//
//        }
//    }
    
    
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
        
//        if(pickerView.tag == 1){
            self.syokuTextField.text! =  selectingText
            selectedPickerText = self.syokuTextField.text!
            self.syokuTextField.endEditing(true)
//        }else {
            self.syozokuTextField.text! =  selectingText2
            selectedPickerText2 = self.syozokuTextField.text!
            self.syozokuTextField.endEditing(true)
//        }
    }
    
    //pickerView button_ cancel 取り消し
    @objc func cancel() {
        //window 閉める
        syokuTextField.resignFirstResponder()
        //textField 削除
//      self.syokuTextField.text! = ""
        self.syokuTextField.endEditing(true)
        //        pickerView.selectRow(selectArrayRow, inComponent: 0, animated: true)
        
        //window 閉める
        syozokuTextField.resignFirstResponder()
        //textField 削除
//      self.syokuTextField.text! = ""
        self.syozokuTextField.endEditing(true)
        //        pickerView.selectRow(selectArrayRow, inComponent: 0, animated: true)
    }
}


// MARK: UIpickerView
//UIPickerView 関連 (職業選ぶ)
extension ModifyViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("PickerViewTag : ",pickerView.tag)
        
        if( pickerView.tag == 1 ){
            return syokuArr.count
        } else {
            return syozokuArr.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if( pickerView.tag == 1 ){
            return syokuArr[row]
        } else {
            return syozokuArr[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        syokuTextField.text = syokuArr[row]
    //selectingText = syokuArr[row]
//        syokuTextField.resignFirstResponder()
//        syokuTextField.isUserInteractionEnabled = false
        
        if( pickerView.tag == 1 ){
            selectingText = syokuArr[row]
        } else {
            selectingText2 = syozokuArr[row]
        }
    }

    func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        let pickerView2 = UIPickerView()
        pickerView2.delegate = self
        
        
            syokuTextField.inputView = pickerView
            pickerView.tag = 1
        
            syozokuTextField.inputView = pickerView2
            pickerView2.tag = 2
        
//        syokuTextField.inputView?.tag = 1
//        syozokuTextField.inputView = pickerView
//        syozokuTextField.inputView?.tag = 2
        
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        let button1 = UIBarButtonItem(title: "決定", style: .plain, target: self, action: #selector(self.done))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,target:self,action:nil)
        let button2 = UIBarButtonItem(title: "キャンサル", style: .plain, target: self, action: #selector(self.cancel))
        toolBar.setItems([button2, space, button1], animated: true)
    
        toolBar.isUserInteractionEnabled = true
        syokuTextField.inputAccessoryView = toolBar
        syozokuTextField.inputAccessoryView = toolBar
    }
    
    
    
    
    //MARK: KeyBoard Input restrict
    //入力制限　関連
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(string)
        
        let currStr = textField.text! as NSString
        let changed = currStr.replacingCharacters(in: range, with: string)
        
        var numR:Int = 0
        var strR:String = ""
        
        switch textField {
        case name_kz:
            numR = 10
            strR = "^[ぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]*$"
        case name_kana:
            numR = 10
            strR = "^[ぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]*$"
            print("KANA")
        case name_eng:
            numR = 10
            strR = "^[a-zA-Z]*$"
        default:
            numR = 10
            strR = "^[a-zA-Z]*$"
        }
        
        // max length
         guard changed.count <= numR else {
             return false
         }
        print("length OK, Exp:",strR)
        
        // 入力制限
         let patternStr = strR //!!
         return changed.range(of: patternStr, options: .regularExpression) != nil
        
    }
    

}






//
//  InsertViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/14.
//

import UIKit
import Foundation


class InsertViewController: UIViewController {
    
    //DB
    var database = Database()
    
    var insertValue : InsertValue = InsertValue()
    
    var user:User = User(USER_NUM: "", USER_ID: "", USER_PASS: "", NAME_KZ: "", NAME_KANA: "", NAME_ENG: "", TELL: "", GENDER: 1, POSITION: 1, TEAM: 1, MAGAZINE: 1, MEMO: "", INSERT_DATE: "")
    
    //scroll 関連
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var formView: UIView!
    
    //member 変
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw1: UITextField!
    @IBOutlet weak var pw2: UITextField!
    
    //name
    @IBOutlet weak var name_kz: UITextField!
    @IBOutlet weak var name_kana: UITextField!
    @IBOutlet weak var name_eng: UITextField!
    //tel
    @IBOutlet weak var tel1: UITextField!
    @IBOutlet weak var tel2: UITextField!
    @IBOutlet weak var tel3: UITextField!
    
    
    @IBOutlet weak var memo: UITextView!
    
    //uiSwitch メールマガジン
    @IBOutlet weak var uiSwitch: UISwitch!
    var switchBool : Bool = true
    
    //validation check 項目
    var idValiFlag : Bool = false
    var pwValiFlag : Bool = false
    var nameValiFlag : Bool = false
    var telValiFlag : Bool = false
    
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
    
    //PickerView1
    @IBOutlet weak var syokuTextField: UITextField!
    let syokuArr = ["平社員","主任","課長","部長","次長","代表"]
    var syokuPickerView = UIPickerView()
    
    //PickerView2
    @IBOutlet weak var syozokuTextField: UITextField!
    let syozokuArr = ["第１チーム","第２チーム","第３チーム","第４チーム","第５チーム","第６チーム"]
    var syozokuPickerView = UIPickerView()
    
    
    
    
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
    
    //init , textField
    func textFieldInit() {
        id.text = ""
        pw1.text = ""
        pw2.text = ""
        
        name_kz.text = ""
        name_kana.text = ""
        name_eng.text = ""
        
        tel1.text = ""
        tel2.text = ""
        tel3.text = ""
        
        //性別radio button default値
        maleRadio.isSelected = true
        maleRadio.setImage(maleRadio.isSelected ? ChkMale : noneChkMale, for: .normal)
        femaleRadio.isSelected = false
        femaleRadio.setImage(femaleRadio.isSelected ? ChkFemale : noneChkFemale, for: .normal)
        
        syokuTextField.text = "平社員"
        syozokuTextField.text = "第１チーム"
        
        //magazine
        uiSwitch.setOn(true, animated: false)
        switchBool = true
        
        //checkBox default値
        checkBox.isSelected = false
        checkBox.setImage(checkBox.isSelected ? checkImage : noneCheckImage, for: .normal)
        
        memo.text = ""
    }
    
    //
    var dataFlag:Int = 0
    //
    
    override func viewWillAppear(_ animated: Bool) {
        print("入力画面viewWillAppear")
        
        print("dataFlag:",dataFlag)
        
        if(dataFlag == 1){
            print("x button 押す")
        }else{
           textFieldInit()
        }
        
        dataFlag = 0
        
        print("dataFlag:",dataFlag)
        
    }
    
    @IBAction func exitSegue(segue : UIStoryboardSegue){
        
        let vc = segue.source as? Detail_InsertViewController
        
        print("dataFlag2:",vc!.dataFlag2)
        
        dataFlag = vc!.dataFlag2
    }
    
    
//    override func viewDidDisappear(_ animated: Bool) {
//        print("入力画面viewDidDisappear")
//
//        textFieldInit()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scroll
        scrollView.contentSize = CGSize(width: formView.frame.width, height: formView.frame.height)
        
        //pickerView
        syokuTextField.text = "平社員"
        syokuTextField.tintColor = .clear
        syokuTextField.textAlignment = .center
        syokuTextField.inputView = syokuPickerView
    
        selectingText = "平社員"
        selectedPickerText = "平社員"
        
//        syokuPickerView.delegate = self
//        syokuPickerView.dataSource = self
        
        syozokuTextField.text = "第１チーム"
        syozokuTextField.tintColor = .clear
        syozokuTextField.textAlignment = .center
        syozokuTextField.inputView = syokuPickerView
        
        selectingText2 = "第１チーム"
        selectedPickerText2 = "第１チーム"
        
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
//        pw1.delegate = self
//        pw2.delegate = self
        
        name_kz.delegate = self
        name_kana.delegate = self
        name_eng.delegate = self
        
        //keyboard type
        id.keyboardType = .asciiCapable
        //
        pw1.keyboardType = .asciiCapable
        pw2.keyboardType = .asciiCapable
        
        name_eng.keyboardType = .asciiCapable
        
        //keyboard down
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        
        //keyboard up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //DB
        database.openDB()
        
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
    
    //id
    
    
    //pop-up Massage func
    func alertMessage(title:String, textFd:UITextField){
            alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
            
            let alertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                textFd.becomeFirstResponder()
            })
            
            alert.addAction(alertAction)
            
            self.present(alert, animated: true, completion: nil)
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
        
       
//        var idCheck:Int = 0
//        let idIP:String = id.text!
        
        //ID 重複チェック
        let idCheck = database.idCheck(idIP: id.text!)

        if idCheck == 1 {
            alert = UIAlertController(title: "そのIDは既に存在しています。他のIDを使ってください。", message: "", preferredStyle: UIAlertController.Style.alert)

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
    
    func nameValidation() -> Bool {
        //空白チェック
        if name_kz.text!.isEmpty, name_kz.text! == "" {
            alertMessage(title: "名前(漢字)を入力してください。", textFd: name_kz)
            return false
        }
        if name_kana.text!.isEmpty, name_kana.text! == "" {
            alertMessage(title: "名前(カナ)を入力してください。", textFd: name_kana)
            return false
        }
        if name_eng.text!.isEmpty, name_eng.text! == "" {
            alertMessage(title: "名前(英語)を入力してください。", textFd: name_eng)
            return false
        }
        return true
    }
    
    func telValidation() -> Bool {
        //空白チェック
        if tel1.text!.isEmpty, tel1.text! == "" {
            alertMessage(title: "電話番号(1)を入力してください。", textFd: tel1)
            return false
        }
        if tel2.text!.isEmpty, tel2.text! == "" {
            alertMessage(title: "電話番号(2)を入力してください。", textFd: tel2)
            return false
        }
        if tel3.text!.isEmpty, tel3.text! == "" {
            alertMessage(title: "電話番号(3)を入力してください。", textFd: tel3)
            return false
        }
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
        
        //vali func2-2
        nameValiFlag = nameValidation()
            
        //vali func2-3
        telValiFlag = telValidation()
        
        //vali func3
        yakkannCheckFlag = yakkannCheck()
        
        //f1,f2,f3 = All valiFlag check
        print("id Flag : ",  idValiFlag)
        print("pw Flag : ",  pwValiFlag)
        print("yakkann Flag : ",  yakkannCheckFlag)
        
        if(idValiFlag && pwValiFlag && nameValiFlag && telValiFlag && yakkannCheckFlag ){
            print("All PASS")
            //入力したデータ
//            insertValue = InsertValue(id: id.text!, syoku: syokuTextField.text!,
//            gender: maleBool, mail_magazine: switchBool, yakkann: true, memo: memo.text!)
            
            //入力したデータ
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
            
            user = User(USER_NUM: "", USER_ID: id.text!, USER_PASS: pw1.text!, NAME_KZ: name_kz.text!, NAME_KANA: name_kana.text!, NAME_ENG: name_eng.text!, TELL: tel, GENDER: gen, POSITION: posi, TEAM: team, MAGAZINE: mgz, MEMO: memo.text!, INSERT_DATE: "")
            
            
            print(memo.text!)
            
            //flag check func _ flag 1,2,3 check -> OK -> 登録完了、確認画面に移動
            self.performSegue(withIdentifier: "showInsertMember", sender: nil)
        }
    }
    
    
    // MARK: segue prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInsertMember" {
            guard let destination = segue.destination as? Detail_InsertViewController else {
                fatalError("Failed to prepare DetailViewController.")

            }
                //data tennsou
            //destination.insertValue = self.insertValue
        
            destination.user = user
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


//UIPickerView 関連 (職業選ぶ)
extension InsertViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

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
            
        case id:
            numR = 50
            strR = "^[a-zA-Z0-9@.]*$"
            print("id input")
        case name_kz:
            numR = 10
            strR = "^[ぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]*$"
        case name_kana:
            numR = 10
            strR = "^[ぁ-んァ-ヶｱ-ﾝﾞﾟ]*$"
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






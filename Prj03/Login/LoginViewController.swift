//
//  LoginViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/10/18.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw: UITextField!
    
    var database = Database()
    var datas = [User]()
    
    
    //About csv -------
    //csv用の Arrayを用意します。
    var csvArr: [String] = []
    
    var dataArr: [User] = []
    
    // ----------------
    
    
    //LOGIN BUTTON
    @IBAction func loginAction(_ sender: UIButton) {
        //空白チェック
        guard idValidation() else { return }
        guard pwValidation() else { return }
        
        let idA:String = id.text!
        let pwA:String = pw.text!
        
        //Login Flag
        var flag:Int = 10//初期値
        
//        database.openDB()
        
        database.openDB()
        flag = database.login(id: idA, pw: pwA)
        print("Login_flag :", flag)
        
        //ログイン
        guard loginCheck(flag: flag) else { return }
        print("ログイン成功")
        
        database.closeDB()
        
        //segue
        self.performSegue(withIdentifier: "showListMember", sender: nil)
        
    }
    
    //alert
    var alert : UIAlertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataCheck()
        
        id.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    //データチェック
    func loadDataCheck() {
        var data_flag:Int = 3
//        database.openDB()
        
        database.openDB()
        
        data_flag = database.dataCheck()
        
        database.closeDB()
        
        print("data_flag:",data_flag)
        
        if(data_flag == 0 ){
            //データがい無い時
            database.openDB()
            database.createTable()
            database.closeDB()
            
            
            csvArr = loadCSV(fileName: "dataList3")
            loadData()
            
            database.openDB()
            database.insertCSV(userArr: dataArr)
            database.closeDB()
            print("「RELOADED FROM CSV FILE」")
        }else{
            print(" CSV LOAD FAIL : もうすでに、DBが存在しています。")
        }
    }
    
    

    //初期化ログイン csv, (+ drop table, create table )
    func initializeDB() -> Bool {
        if id.text! == "admin" && pw.text! == "gngs1234" {
            //drop table
            
            //create table
            
            //csv -> DB
            
            return false
        }
        return true
    }
    
    //id
    func idValidation() -> Bool {
        //空白チェック
        if id.text!.isEmpty, id.text! == "" {
            alert = UIAlertController(title: "アカウントを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)

            let idAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.id.becomeFirstResponder()
            })

            alert.addAction(idAlertAction)

            self.present(alert, animated: false, completion: nil)
            
            return false
        }
        return true
    }
    
    //pw
    func pwValidation() -> Bool {
        //空白チェック pw1
        if pw.text!.isEmpty, pw.text! == "" {
            alert = UIAlertController(title: "パスワードを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: false, completion: nil)
            
            return false
            
        }
        return true
    }
  
    //
    func loginCheck(flag: Int) -> Bool {
        if( flag == -1 ){
            print("IDが無し\n")
            alert = UIAlertController(title: "アカウントを確認できません。\n もう一と確認してください。", message: "", preferredStyle: UIAlertController.Style.alert)

            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw.becomeFirstResponder()
            })

            alert.addAction(pw1AlertAction)

            self.present(alert, animated: false, completion: nil)

            return false
        }
        if( flag == -2 ){
            print("pwを間違い\n")
            alert = UIAlertController(title: "パスワードが違います。\n もう一と確認してください。", message: "", preferredStyle: UIAlertController.Style.alert)

            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw.becomeFirstResponder()
            })

            alert.addAction(pw1AlertAction)

            self.present(alert, animated: false, completion: nil)

            return false
        }
        return true
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //func for CSVdata into cssArr[]
    func loadCSV(fileName: String) -> [String] {
          let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
          
//            let lineChange = csvData.replacingOccurrences(of: "\r\n", with: "\n").replacingOccurrences(of: "\r", with: "\n")
//            csvArr = lineChange.components(separatedBy: "\n")
            
            csvArr = csvData
                .replacingOccurrences(of: "\r\n", with: "\n")
                .replacingOccurrences(of: "\r", with: "\n")
                .components(separatedBy: "\n")

            csvArr.removeLast()
        } catch {
            print("エラー　loadCSV func 関連　")
        }
        return csvArr
    }
    
    func loadData(){
        //reset
        self.dataArr.removeAll()
        
    //func for csvArr[].seperated -> dataArr[].append
        for numInt in 0...csvArr.count-1 {
            var arr:[String] = []
            arr = csvArr[numInt].description.components(separatedBy: ",")
        
//          let aaa = arr[7] == nil ? 1 : Int8(arr[7]) ?? 1
            
            
            
            //print(csvArr[numInt])
            
            
            var gen: Int8 = 3
            
            if(arr[7] == "1"){
                gen = 1
            }else{
                gen = 0
            }
            
            let team = Int8(arr[9])!
            
            let posi = Int8(arr[8])!
            
//            print("CSV :" + arr[10])
            
            let item = User(USER_NUM: arr[0], USER_ID: arr[1], USER_PASS: arr[2], NAME_KZ: arr[3], NAME_KANA: arr[4], NAME_ENG: arr[5], TELL: arr[6], GENDER: gen, POSITION: posi, TEAM: team, MAGAZINE: 0, MEMO: "", INSERT_DATE: arr[10])

            self.dataArr.append(item)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
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
            strR = "^[a-zA-Z0-9@_.]*$"
            print("id input")

        default:
            numR = 50
            strR = "^[a-zA-Z0-9@.]*$"
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

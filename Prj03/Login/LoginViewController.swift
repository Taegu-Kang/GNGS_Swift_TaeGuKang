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
    
    //login button
    @IBAction func loginAction(_ sender: UIButton) {
        //初期化ログイン
        
        //
        guard idValidation() else { return }
        guard pwValidation() else { return }
        guard loginCheck() else { return }
        self.performSegue(withIdentifier: "showListMember", sender: nil)
        
        
    }
    
    //alert
    var alert : UIAlertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        // Do any additional setup after loading the view.
    }
    
    //id
    func idValidation() -> Bool {
        //空白チェック
        if id.text!.isEmpty, id.text! == "" {
            alert = UIAlertController(title: "ユーザIDを入力してください。", message: "", preferredStyle: UIAlertController.Style.alert)

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
    
    func loginCheck() -> Bool {
        datas = database.userDatastore.findById(id: id.text!)
        let result: String? = datas.last?.pw
        print(result as Any)
        if result == nil {
            print("IDが無し")
            alert = UIAlertController(title: "ユーザIDが一致しません。", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let pw1AlertAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.pw.becomeFirstResponder()
            })
            
            alert.addAction(pw1AlertAction)
            
            self.present(alert, animated: false, completion: nil)
            
            return false
        }
        if(result != pw.text!){
            print("pwを間違い")
            alert = UIAlertController(title: "パスワードが一致しません。", message: "", preferredStyle: UIAlertController.Style.alert)
            
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

}

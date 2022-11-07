//
//  Detail_InsertViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/21.
//

import UIKit

class Detail_InsertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //DB
    var database = Database()

    var insertValue : InsertValue = InsertValue()
    
    @IBOutlet weak var tableView: UITableView!
    
    var cell : UITableViewCell = UITableViewCell()
    
    var detailTitle : [String]  = ["ID(メールアドレス)","名前(漢字)","名前(カナ)","名前(英語)","電話番号", "役職","所属","性別","メールマガジン","約款同意","メモ"]
    
    var detailContext : [String] = []
    
    var user:User = User(USER_NUM: "", USER_ID: "", USER_PASS: "", NAME_KZ: "", NAME_KANA: "", NAME_ENG: "", TELL: "", GENDER: 1, POSITION: 1, TEAM: 1, MAGAZINE: 1, MEMO: "", INSERT_DATE: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        prepareCon()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func insertButton(_ sender: Any) {
        
        
        //
        database.openDB()
        //database.update(user: user)
        
        database.insertUser(user: user)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailTitle.count
    }
    
    //Cell 生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        return cell
        
    }
    
    //Cell 表示
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let label1 = cell.contentView.viewWithTag(1) as! UILabel
        let label2 = cell.contentView.viewWithTag(2) as! UILabel
       
        label1.text = detailTitle[indexPath.item]
        
//        if(detailContext.array){
//
//        }
        
        
        label2.text = detailContext[indexPath.item]
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func prepareCon() {
        detailContext.append(user.USER_ID)
        //name
        detailContext.append(user.NAME_KZ)
        detailContext.append(user.NAME_KANA)
        detailContext.append(user.NAME_ENG)
        //tel
        detailContext.append(user.TELL)
        //syoku
        detailContext.append(String(user.POSITION))
        //syozoku
        detailContext.append(String(user.TEAM))
        
        detailContext.append(String(user.GENDER))
        detailContext.append(String(user.MAGAZINE))
        detailContext.append("同義")
        
        
//        if(insertValue.gender){
//            detailContext.append("男性")
//        }else{
//            detailContext.append("女性")
//        }
//        if(insertValue.mail_magazine){
//            detailContext.append("許可")
//        }else{
//            detailContext.append("却下")
//        }
//        if(insertValue.yakkann){
//            detailContext.append("同義")
//        }else{
//            detailContext.append("非同義")
//        }
        
        
        if(user.MEMO == ""){
            detailContext.append("なし")
        }else{
            detailContext.append(user.MEMO)
        }
    }
    

}

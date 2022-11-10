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
    
    var memoArr: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var cell : UITableViewCell = UITableViewCell()
    
    var detailTitle : [String]  = ["ID(メールアドレス)","名前(漢字)","名前(カナ)","名前(英語)","電話番号", "役職","所属","性別","メールマガジン","約款同意","メモ"]
    
    var detailContext : [String] = []
    
    var user:User = User(USER_NUM: "", USER_ID: "", USER_PASS: "", NAME_KZ: "", NAME_KANA: "", NAME_ENG: "", TELL: "", GENDER: 1, POSITION: 1, TEAM: 1, MAGAZINE: 1, MEMO: "", INSERT_DATE: "")
    
    let syozokuArr = ["第１チーム","第２チーム","第３チーム","第４チーム","第５チーム","第６チーム"]
    
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
        //DB
        database.openDB()
        
        database.insertUser(user: user)
        
        //self.presentingViewController?.dismiss(animated: true)
        
        //perform segue
        
        self.performSegue(withIdentifier: "showHomeVC", sender: nil)
    }
    
    // MARK: segue prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHomeVC" {
//            guard let destination = segue.destination as? Detail_InsertViewController else {
//                fatalError("Failed to prepare DetailViewController.")
//            }
                //data tennsou
            //destination.insertValue = self.insertValue
        
            self.presentingViewController?.dismiss(animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailContext.count
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
        //役職
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
        detailContext.append(posi)
        
        //syozoku
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
        detailContext.append(zoku)
        
        //Gender
        if(user.GENDER == 1){
            detailContext.append("男性")
        }else{
            detailContext.append("女性")
        }
        
        //Magazine
        if(user.MAGAZINE == 1){
                    detailContext.append("同意")
                }else{
                    detailContext.append("非同意")
                }
        detailContext.append("同意")
        

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
            memoArr = user.MEMO
                .replacingOccurrences(of: "\r\n", with: "\n")
                .replacingOccurrences(of: "\r", with: "\n")
                .components(separatedBy: "\n")
            
            if((memoArr.last)?.count == 0){
                memoArr.removeLast()
            }
            
            for num in 0...memoArr.count-1{
                detailTitle.append("")
                detailContext.append(memoArr[num])
            }
        }
    
        
    }
}

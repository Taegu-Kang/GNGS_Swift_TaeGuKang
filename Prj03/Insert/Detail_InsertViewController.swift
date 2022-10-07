//
//  Detail_InsertViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/21.
//

import UIKit

class Detail_InsertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var insertValue : InsertValue = InsertValue()
    
    @IBOutlet weak var tableView: UITableView!
    
    var cell : UITableViewCell = UITableViewCell()
    
    var detailTitle : [String]  = ["ID", "職業","性別","メールマガジン","約款同意","メモ"]
    
    var detailContext : [String] = []
    
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
        detailContext.append(insertValue.id)
        detailContext.append(insertValue.syoku)
        if(insertValue.gender){
            detailContext.append("男性")
        }else{
            detailContext.append("女性")
        }
        if(insertValue.mail_magazine){
            detailContext.append("同義")
        }else{
            detailContext.append("非同義")
        }
        if(insertValue.yakkann){
            detailContext.append("同義")
        }else{
            detailContext.append("非同義")
        }
        if(insertValue.memo == ""){
            detailContext.append("なし")
        }else{
            detailContext.append(insertValue.memo)

        }
    }
    

}

//
//  DetailViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/13.
//

import UIKit
import Foundation

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var detailCell: SyainnValue = SyainnValue(syaNum: "", name: "", nameKana: "", nameEng: "", yaku: "", syozoku: "", mail: "", phoneNum: "")

    var detailCellArr : [String] = []
    
    var detailTitle : [String]  = ["社員番号", "名前（漢字）","名前（カナ）","名前（英語）","役職","所属","メール","電話番号"]
    
    var cell : UITableViewCell = UITableViewCell()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        detailCellArr.append(detailCell.syaNum)
        detailCellArr.append(detailCell.name)
        detailCellArr.append(detailCell.nameKana)
        detailCellArr.append(detailCell.nameEng)
        detailCellArr.append(detailCell.yaku)
        detailCellArr.append(detailCell.syozoku)
        detailCellArr.append(detailCell.mail)
        detailCellArr.append(detailCell.phoneNum)
        

    }
    
    @IBAction func toTableButtonAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true ) 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailTitle.count
    }
    
    //Cell生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        return cell
        
    }
    
    //Cell 表示
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let label1 = cell.contentView.viewWithTag(1) as! UILabel
        let label2 = cell.contentView.viewWithTag(2) as! UILabel
       
        label1.text = detailTitle[indexPath.item]
        label2.text = detailCellArr[indexPath.item]
        
        
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

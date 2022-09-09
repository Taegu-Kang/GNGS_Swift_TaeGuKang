//
//  TableViewCell.swift
//  Prj03
//
//  Created by PC115 on 2022/09/09.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let resID = "table_view_cell"
    
    static func register(to tableView: UITableView) {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: resID)
    }

    @IBOutlet weak var syaLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yakuLabel: UILabel!
    @IBOutlet weak var syoLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //display
    func display(data: SyainnValueSample) {
        self.syaLabel.text = data.syaNum
        self.nameLabel.text = data.name
        self.yakuLabel.text = data.yaku
        self.syoLabel.text = data.syozoku
    }
    
    
    ///

}

//
//  SyainnValueCSV.swift
//  Prj03
//
//  Created by PC115 on 2022/09/12.
//

import Foundation

class SyainnValue : ObservableObject {
    
    var syaNum : String
    var name : String
    var nameKana : String
    var nameEng : String
    
    var yaku : String
    var syozoku : String
    var mail : String
    var phoneNum : String
    
    
    init(syaNum:String, name: String, nameKana:String , nameEng: String, yaku : String, syozoku : String, mail : String, phoneNum : String) {
        self.syaNum = syaNum
        self.name = name
        self.nameKana = nameKana
        self.nameEng = nameEng
        self.yaku = yaku
        self.syozoku = syozoku
        self.mail = mail
        self.phoneNum = phoneNum
    }
    
}

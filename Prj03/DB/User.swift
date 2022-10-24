//
//  User.swift
//  Prj03
//
//  Created by PC115 on 2022/10/20.
//

import Foundation

class User {
    let num: Int64
    let id: String
    let nameKZ: String
    let pw: String
    
    init(num: Int64, id: String, nameKZ: String, pw: String) {
        self.num = num
        self.id = id
        self.nameKZ = nameKZ
        self.pw = pw
    }
}

//
//  User.swift
//  Prj03
//
//  Created by PC115 on 2022/10/20.
//

import Foundation

class User {
    
    let USER_NUM: String
    let USER_ID: String
    let USER_PASS: String
    let NAME_KZ: String
    let NAME_KANA: String
    let NAME_ENG: String
    let TELL: String
    let GENDER: Int8
    let POSITION: Int8
    let TEAM: Int8
    let MAGAZINE: Int8
    //    let MEMO: String?
    let INSERT_DATE: String
    //    let UPDATE_DATE: String?
    
    init( USER_NUM: String,
          USER_ID: String,
          USER_PASS: String,
          NAME_KZ: String,
          NAME_KANA: String,
          NAME_ENG: String,
          TELL: String,
          GENDER: Int8,
                    POSITION: Int8,
                    TEAM: Int8,
                    MAGAZINE: Int8,
          //          MEMO: String?
          INSERT_DATE: String
          
        ) {
        self.USER_NUM=USER_NUM
        self.USER_ID=USER_ID
        self.USER_PASS=USER_PASS
        self.INSERT_DATE=INSERT_DATE
        
        self.NAME_KZ=NAME_KZ
        self.NAME_KANA=NAME_KANA
        self.NAME_ENG=NAME_ENG
        self.TELL=TELL
        self.GENDER=GENDER
        self.POSITION=POSITION
        self.TEAM=TEAM
        self.MAGAZINE=MAGAZINE
    // self.MEMO=MEMO
        
    }
}

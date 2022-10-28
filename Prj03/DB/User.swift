//
//  User.swift
//  Prj03
//
//  Created by PC115 on 2022/10/20.
//

import Foundation

class User {
    
    var USER_NUM: String
    var USER_ID: String
    var USER_PASS: String
    var NAME_KZ: String
    var NAME_KANA: String
    var NAME_ENG: String
    var TELL: String
    var GENDER: Int8
    var POSITION: Int8
    var TEAM: Int8
    var MAGAZINE: Int8
    var MEMO: String
    var INSERT_DATE: String
    //    var UPDATE_DATE: String?
    
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
                    MEMO: String,
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
        self.MEMO=MEMO
        
    }
}

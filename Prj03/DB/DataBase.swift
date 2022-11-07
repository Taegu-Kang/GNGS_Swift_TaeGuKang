//
//  DataBase.swift
//  Prj03
//
//  Created by PC115 on 2022/10/20.
//

import Foundation
import SQLite3

class Database {
    
    var db: OpaquePointer?
    let dbfile: String = "sample.db"
    
    func openDB() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.dbfile)
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("DBファイルが見つからず、生成もできません。")
        } else {
            print("DBファイルが生成できました。（対象のパスにDBファイルが存在しました。）")
        }
    }
    
    func createTable() {
        let createTable =
        "CREATE TABLE USER_TABLE (USER_NUM TEXT, USER_ID TEXT, USER_PASS TEXT, NAME_KZ TEXT, NAME_KANA TEXT, NAME_ENG TEXT, TELL TEXT, GENDER INTEGER, POSITION INTEGER, TEAM INTEGER, MAGAZINE INTEGER, MEMO TEXT, INSERT_DATE TEXT, UPDATE_DATE TEXT)"
        
        if sqlite3_exec(db, createTable, nil, nil, nil) != SQLITE_OK {
            print("テーブルの作成に失敗しました。")
        } else {
            print("テーブルが作成されました。")
        }
    }
        
    //insertCSV (arr[])
    func insertCSV(userArr: [User]) {
        var stmt: OpaquePointer?
        
        //現在時間　yyyy-MM-dd
        let dt = Date()
        let dateFormatter = DateFormatter()
        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        print(dateFormatter.string(from: dt))
        
        for x in 0...userArr.count-1 {
            //TEXT 変換のため
            //
//            if(arr[x].GENDER == "male"){
//                arr[x].GENDER = "1"
//            }else{arr[x].GENDER = "0"
//            }
            
            let queryString = "INSERT INTO USER_TABLE (USER_NUM, USER_ID, USER_PASS, NAME_KZ, NAME_KANA, NAME_ENG,  TELL, GENDER , POSITION , TEAM , MAGAZINE, INSERT_DATE) VALUES ('\(userArr[x].USER_NUM)','\(userArr[x].USER_ID)','\(userArr[x].USER_PASS)','\(userArr[x].NAME_KZ)','\(userArr[x].NAME_KANA)','\(userArr[x].NAME_ENG)','\(userArr[x].TELL)','\(userArr[x].GENDER)','\(userArr[x].POSITION)',\(userArr[x].TEAM),\(userArr[x].MAGAZINE),'\(userArr[x].INSERT_DATE)')"
            
            print("query :" + queryString)
            
            // クエリを準備する
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            // クエリを実行する
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting hero: \(errmsg)")
                return
            }
        }
        print("データが登録されました")
    }
    
    //Login _ Select
    func login(id:String, pw:String)-> Int{
        let queryString = "SELECT * FROM USER_TABLE WHERE USER_ID='\(id)'"
        
        var stmt:OpaquePointer?
        var flag:Int = 0
        
        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        // クエリを実行し、取得したレコードをループする
        if(sqlite3_step(stmt) == SQLITE_ROW){
            flag = 1
            
            let queryString = "SELECT * FROM USER_TABLE WHERE USER_PASS='\(pw)'"
            // クエリを準備する
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
            }
            
            // クエリを実行し、取得したレコードをループする
            if(sqlite3_step(stmt) == SQLITE_ROW){
                flag = 2
            }else{
                flag = -2
            }
        }else{
            flag = -1
        }
        return flag
    }
    
    
    
    //DataCheck
    func dataCheck() -> Int{
        let queryString = "SELECT * FROM USER_TABLE"
        
        var stmt:OpaquePointer?
        var flag:Int = 0

        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return flag
        }
        // クエリを実行し、取得したレコードをループする
        if(sqlite3_step(stmt) == SQLITE_ROW){
            flag = 1
        }
        return flag
    }
    
    
    //社員一覧、select
    func selectAll()->[User]{
        let queryString = "SELECT * FROM USER_TABLE"
        
        var stmt:OpaquePointer?
        
        var userArr: [User] = []
        
        //var num:Int = 0
        
        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return userArr
        }
        // クエリを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let user_num = String(cString: sqlite3_column_text(stmt, 0))
     /*id*/ let user_id:String = String(cString: sqlite3_column_text(stmt, 1))
     /*pw*/
            let kz = String(cString: sqlite3_column_text(stmt, 3))
            let kana  = String(cString: sqlite3_column_text(stmt, 4))
            let eng  = String(cString: sqlite3_column_text(stmt, 5))
            let tell  = String(cString: sqlite3_column_text(stmt, 6))
            let gen  = Int8(sqlite3_column_int(stmt, 7))
            let posi  = Int8(sqlite3_column_int(stmt, 8))
            let team  = Int8(sqlite3_column_int(stmt, 9))
            let mgz  = Int8(sqlite3_column_int(stmt, 10))
            //let memo  = String(cString: sqlite3_column_text(stmt, 11))
            
            let item = User(USER_NUM: user_num, USER_ID: user_id, USER_PASS: "", NAME_KZ: kz, NAME_KANA: kana, NAME_ENG: eng, TELL: tell, GENDER: gen, POSITION: posi, TEAM: team, MAGAZINE: mgz, MEMO: "", INSERT_DATE: "")

            userArr.append(item)
            
            //num+=1
        }
        return userArr
    }
    
    //UPDATE
    func update(user: User) {
        var stmt: OpaquePointer?
        
        //+ 変更日
        let queryString = "UPDATE USER_TABLE SET NAME_KZ='\(user.NAME_KZ)', NAME_KANA ='\(user.NAME_KANA)', NAME_ENG ='\(user.NAME_ENG)', TELL ='\(user.TELL)', GENDER =\(user.GENDER), POSITION =\(user.POSITION), TEAM =\(user.TEAM), MAGAZINE =\(user.MAGAZINE), MEMO ='\(user.MEMO)' WHERE USER_NUM =  '\(user.USER_NUM)'"
        
        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // クエリを実行する
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        
        print("データが更新されました")
    }
    
    
    //insertUser (User)
    func insertUser(user: User) {
        var stmt: OpaquePointer?
        
        //現在時間　yyyy-MM-dd
        let dt = Date()
        let dateFormatter = DateFormatter()
        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        
        let inser_date:String = dateFormatter.string(from: dt)
        
        print(inser_date)
        
        
        
            //社員番号(USER_NUM)(PK) generate   ->  CLASS 作ります。
            let nextUser = numCheck()
        
        
            let queryString = "INSERT INTO USER_TABLE (USER_NUM, USER_ID, USER_PASS, NAME_KZ, NAME_KANA, NAME_ENG,  TELL, GENDER , POSITION , TEAM , MAGAZINE, INSERT_DATE) VALUES ('\(nextUser)','\(user.USER_ID)','\(user.USER_PASS)','\(user.NAME_KZ)','\(user.NAME_KANA)','\(user.NAME_ENG)','\(user.TELL)','\(user.GENDER)','\(user.POSITION)',\(user.TEAM),\(user.MAGAZINE),'\(inser_date)')"
            
            print("query :" + queryString)
            
            // クエリを準備する
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            // クエリを実行する
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting hero: \(errmsg)")
                return
            }
        
        print("データが登録されました")
    }
    
    
    //USER_NUM redundant_check
    func numCheck()->String{
        let queryString = "SELECT * from USER_TABLE ORDER BY DESC USER_NUM DESC LIMIT 1"
        
        var nextUser:String = ""
        
        var stmt:OpaquePointer?
        
        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return nextUser
        }
        
        // クエリを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            nextUser = String(cString: sqlite3_column_text(stmt, 0))

            print("USER_NUM : \(nextUser)")
        }
        
        var arr:[String] = []
        
        arr = nextUser.description.components(separatedBy: "-")
        
        arr[1] = String(Int(arr[1])! + 1 )
        
        nextUser = arr[0] + "-" + arr[1]
        
        return nextUser
    }
    
    
    
    
    //
    //select TEST
    func select(){
        let queryString = "SELECT * FROM USER_TABLE WHERE USER_NUM=''"
        
        var stmt:OpaquePointer?

        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // クエリを実行し、取得したレコードをループする
        if(sqlite3_step(stmt) == SQLITE_ROW){
            let num = String(cString: sqlite3_column_text(stmt, 0))
            let kz = String(cString: sqlite3_column_text(stmt, 3))
//            let kz = sqlite3_column_int(stmt, 3)
            print(678)
            
            print("USER_NUM : \(num)")
            print("USER_KZ : \(kz)")
        }
    }
    
}

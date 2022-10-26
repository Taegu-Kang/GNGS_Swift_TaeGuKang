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
            
            let queryString = "INSERT INTO USER_TABLE (USER_NUM, USER_ID, USER_PASS, NAME_KZ, NAME_KANA, NAME_ENG,  TELL, GENDER , POSITION , TEAM , MAGAZINE, INSERT_DATE) VALUES ('\(userArr[x].USER_NUM)','\(userArr[x].USER_ID)','\(userArr[x].USER_PASS)','\(userArr[x].NAME_KZ)','\(userArr[x].NAME_KANA)','\(userArr[x].NAME_ENG)','\(userArr[x].TELL)','\(userArr[x].GENDER)','\(userArr[x].POSITION)',\(userArr[x].TEAM),\(userArr[x].MAGAZINE),\(userArr[x].INSERT_DATE))"
            
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
    func Login(id:String, pw:String)-> Int{
        let queryString = "SELECT * FROM USER_TABLE WHERE USER_ID='\(id)'"
        
        var stmt:OpaquePointer?
        var row:Int = 0
        
        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        // クエリを実行し、取得したレコードをループする
        if(sqlite3_step(stmt) == SQLITE_ROW){
            let queryString = "SELECT * FROM USER_TABLE WHERE USER_PASS='\(pw)'"
            
            // クエリを準備する
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
            }
            
            // クエリを実行し、取得したレコードをループする
            if(sqlite3_step(stmt) == SQLITE_ROW){
                row = 1
            }
        }else{
            row = -1
        }
        return row
    }
    
    
    
    //DataCheck
    func dataCheck() -> Int{
        let queryString = "SELECT * FROM USER_TABLE"
        
        var stmt:OpaquePointer?
        var row:Int = 0

        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return row
        }
        // クエリを実行し、取得したレコードをループする
        if(sqlite3_step(stmt) == SQLITE_ROW){
            row = 1
        }
        return row
    }
    
    
    
    //select TEST
    func select(){
        let queryString = "SELECT * FROM USER_TABLE WHERE USER_NUM=''"
        
        var stmt:OpaquePointer?
        
        print(123)
        
        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // クエリを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let num = String(cString: sqlite3_column_text(stmt, 0))
            let kz = String(cString: sqlite3_column_text(stmt, 3))
//            let kz = sqlite3_column_int(stmt, 3)
            print(678)
            
            print("USER_NUM : \(num)")
            print("USER_KZ : \(kz)")
        }
    }
    
}

//
//  DataBase.swift
//  Prj03
//
//  Created by PC115 on 2022/10/20.
//

import Foundation
import SQLite



let FILE_NAME = "sample.db"

class Database {
    let db: Connection
    let userDatastore: UserDatastore
    
    init() {
        // DBファイルの作成先のパスを生成
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(FILE_NAME).path
        // DBファイル作成/開く
        db = try! Connection(filePath)
        
        // UserDatastoreを初期化
        userDatastore = UserDatastore(db: db)
    }
}

class UserDatastore {
    private let table = Table("USER_TABLE")
    private let num = Expression<Int64>("USER_NUM")
    private let id = Expression<String>("USER_ID")
    private let pw = Expression<String>("USER_PASS")
    private let nameKZ = Expression<String>("NAME_KZ")
    private let db: Connection
    
    init(db: Connection) {
        self.db = db
        do {
            try self.db.run(table.create { t in
                t.column(Expression<Int64>("USER_NUM"), primaryKey: true)
                t.column(Expression<String>("USER_ID"), unique: true)
                t.column(Expression<String>("USER_PASS"))
                t.column(Expression<String>("NAME_KZ"))
            })
            // 初期データを入れる
            let migrationItems = [
                ["id":"gngs@gngs.co.jp", "nameKZ": "加藤", "pw":"1234"],
                ["id":"bob@mac.com", "nameKZ": "田中", "pw":"gngservice123"],
                ["id":"hitomi@mac.com", "nameKZ": "瞳", "pw":"gngservice123"]
            ]
            migrationItems.forEach { row in
                try? insert(id: row["id"]!, nameKZ: row["nameKZ"]!, pw: row["pw"]!)
            }
        } catch {}
    }
    
    func insert(id: String, nameKZ: String, pw: String) throws {
        let insert = table.insert(self.id <- id, self.nameKZ <- nameKZ, self.pw <- pw)
        try db.run(insert)
    }
    
    func findById(id: String) -> [User] {
        var results = [User]()
        // エラー起こした場合は空の配列を返却
        guard let users = try? db.prepare(table.where(self.id == id)) else {
            return results
        }
        for row in users {
            results.append(User(num: row[self.num], id: row[self.id], nameKZ: row[self.nameKZ], pw: row[self.pw]))
        }
        return results
    }
    
}

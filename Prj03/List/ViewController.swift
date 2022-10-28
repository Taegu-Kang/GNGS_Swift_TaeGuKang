//
//  ViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/07.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
//    let employee = [[String]](repeating: Array(repeating: "01社員",count: 4 ), count: 50)
      var dataArr: [SyainnValueSample] = []
    
      var detailArr: [SyainnValue] = []
    
    //csv用の Arrayを用意します。
      var csvArr: [String] = []
    
    //DB
    var database = Database()
    //
    var dbArr: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewCell.register(to: tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
//
//      self.view.addSubview(self.tableView)
//

        //CSV読み込む
//        csvArr = loadCSV(fileName: "dataList")
//        loadData()
//        loadData2()
        
        
        // DB -> dataArr 
        database.openDB()
        dbArr = database.selectAll()
        
        loadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    // Cell生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        var str:String = ""
//            for j in 0...3 {
//                str = str + employee[indexPath.row][j]+"       "
//            }
//        cell.textLabel!.text = str
//
//        return cell
        
        tableView.dequeueReusableCell(withIdentifier: TableViewCell.resID, for: indexPath)
    }
    
    // Cell表示
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else {
            assert(false)
            return
        }
        
        let item = self.dataArr[indexPath.row]
        
//      print("item \(item.name)")
        cell.display(data: item )
        
    }
    
    //Segue for DetailView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deselectRow
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetailMember", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailMember" {
            if let indexPath = tableView.indexPathForSelectedRow {

                guard let destination = segue.destination as? DetailViewController else {
                    fatalError("Failed to prepare DetailViewController.")
                }

                destination.detailCell = detailArr[indexPath.row]
            }
        }
    }
    
    
    //func for CSVdata into cssArr[]
    func loadCSV(fileName: String) -> [String] {
          let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArr = lineChange.components(separatedBy: "\n")
            csvArr.removeLast()
        } catch {
            print("エラー　loadCSV func 関連　")
        }
        return csvArr
    }
    
    
    func loadData(){
        self.dataArr.removeAll()
        
        //func for DummyData
//        for numInt in 1...40 {
//            var str = "01-1234"
//            if(numInt < 10 ){
//                str = str + "0"
//            }
//            let item = SyainnValueSample(syaNum: str+"\(numInt)", name: "加藤", yaku: "社員", syozoku: "第１チーム")
//            self.dataArr.append(item)
//        }
    //func for csvArr[].seperated -> dataArr[].append
        for numInt in 0...dbArr.count-1 {
            var user: User
            user = dbArr[numInt]
            
           var posi:String = ""
            switch user.POSITION {
            case 1:
                posi = "平社員"
            case 2:
                posi = "主任"
            case 3:
                posi = "課長"
            case 4:
                posi = "部長"
            case 5:
                posi = "次長"
            case 6:
                posi = "部長"
            default:
                posi = "平社員"
            }
            
            var team:String = ""
            switch user.TEAM {
            case 1:
                team = "第１チーム"
            case 2:
                team = "第2チーム"
            case 3:
                team = "第3チーム"
            case 4:
                team = "第4チーム"
            default:
                team = "第１チーム"
            }

            let item = SyainnValueSample(syaNum: user.USER_NUM, name: user.NAME_KZ, yaku: posi, syozoku: team)
            
            self.dataArr.append(item)
        }
    }
    
    
    
    
    
    
    //社員情報
    //for DetailViewCell
    func loadData2(){
        for numInt in 0...csvArr.count-1 {
            var arr:[String] = []
            arr = csvArr[numInt].description.components(separatedBy: ",")

            let syainn : SyainnValue = SyainnValue( syaNum: arr[0], name: arr[1], nameKana : arr[2], nameEng: arr[3], yaku: arr[4], syozoku: arr[6], mail: arr[7], phoneNum: arr[9] )
            
            self.detailArr.append(syainn)
        }
    }
}

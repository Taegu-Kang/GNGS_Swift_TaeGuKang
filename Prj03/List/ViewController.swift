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

    //csv用の Array 用意します。
      var csvArr: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewCell.register(to: tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
//
//      self.view.addSubview(self.tableView)
//

        csvArr = loadCSV(fileName: "dataList")
        print(csvArr)
        
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
    
    //deselectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //func for DummyData
    func loadData(){
        
        self.dataArr.removeAll()
        
//        for numInt in 1...40 {
//            var str = "01-1234"
//            if(numInt < 10 ){
//                str = str + "0"
//            }
//            let item = SyainnValueSample(syaNum: str+"\(numInt)", name: "加藤", yaku: "社員", syozoku: "第１チーム")
//            self.dataArr.append(item)
//        }
        
        
        //func for csvArr -> loadData
        for numInt in 0...30 {
            var arr:[String] = []
            arr = csvArr[numInt].description.components(separatedBy: ",")
            let item = SyainnValueSample(syaNum: arr[0], name: arr[1], yaku: arr[4], syozoku: arr[6])
            self.dataArr.append(item)
        }
    }
    
    //func for CSVdata into Array
    func loadCSV(fileName: String) -> [String] {
          let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArr = lineChange.components(separatedBy: "\n")
            csvArr.removeLast()
        } catch {
            print("エラー　csv func 関連　")
        }
        return csvArr
    }
    
    
    


}
//
//  ViewController.swift
//  taskMgmt2
//
//  Created by たうんりばー on 2022/02/25.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    // Realmインスタンスを取得する
    let realm = try! Realm()  // ←追加
    
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending : false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // ただの定数と共通関数のテスト
        let const = Const()
        print("=========== １共通変数 ==")
        print(const.mid)
//        Util.printer("印刷してください")
        Util.prt()
        Util.printer(str:"aaa")
        
    }
        
        // MARK: UITableViewDataSourceプロトコルのメソッド
        // データの数（＝セルの数）を返すメソッド
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return taskArray.count
        }

        // 各セルの内容を返すメソッド
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // 再利用可能な cell を得る
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

            let task = taskArray[indexPath.row]
            cell.textLabel?.text = task.title

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"

            let dateString:String = formatter.string(from: task.date)
            cell.detailTextLabel?.text = dateString
            
            return cell
        }

        // MARK: UITableViewDelegateプロトコルのメソッド
        // 各セルを選択した時に実行されるメソッド
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "cellSegue",sender: nil) // ←追加する

        }

        // セルが削除が可能なことを伝えるメソッド
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
            return .delete
        }

        // Delete ボタンが押された時に呼ばれるメソッド
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            // --- ここから ---
               if editingStyle == .delete {
                   // データベースから削除する
                   try! realm.write {
                       self.realm.delete(self.taskArray[indexPath.row])
                       tableView.deleteRows(at: [indexPath], with: .fade)
                   }
               } // --- ここまで追加 ---
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let inputViewController:InputViewController = segue.destination as! InputViewController

        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
        } else {
            let task = Task()
            task.date = Date()

            let allTasks = realm.objects(Task.self)
            if allTasks.count != 0 {
                task.id = allTasks.max(ofProperty: "id")! + 1
            }

            inputViewController.task = task
        }
    }
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }

}


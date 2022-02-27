//
//  SettingViewController.swift
//  taskMgmt2
//
//  Created by たうんりばー on 2022/02/27.
//

import UIKit
import RealmSwift

class SettingViewController: UIViewController {

    @IBOutlet weak var clientIdTextField: UITextField!
    @IBOutlet weak var clientSecretTextField: UITextField!
    
 //   var clientSettings: ClientSettings!
    let realm = try! Realm()
    var clientSettings = ClientSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // 設定された各種データを取得する
    override func viewWillAppear(_ animated: Bool) {
        let results = realm.objects(ClientSettings.self)
        clientIdTextField.text = results[0].clientId
        clientSecretTextField.text = results[0].clientSecret
    }
    
    // 保存ボタンを押下して設定を保存する。
    @IBAction func pressSaveBtn(_ sender: Any) {
        // 保存動作
        try! realm.write {
            self.clientSettings.clientId = self.clientIdTextField.text!
            self.clientSettings.clientSecret = self.clientSecretTextField.text!
                // 古い書き方            self.realm.add(self.task, update: true)
            self.realm.add(self.clientSettings, update: .modified)
        }
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
}

import RealmSwift
import Foundation

class Settings: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0

    // Sec
    @objc dynamic var clientId =  ""

    // タイトル
    @objc dynamic var clientSecret = ""

    /// 日時
    @objc dynamic var UpdateTimeStamp = Date()
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}

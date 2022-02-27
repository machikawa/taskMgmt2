import RealmSwift
import Foundation

class ClientSettings: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0

    // Sec
    @objc dynamic var clientId =  "aa"

    // タイトル
    @objc dynamic var clientSecret = "bb"

    /**
     id をプライマリーキーとして設定。Update : modified なので、PKが重複したらUpdateになる。
     */
    override static func primaryKey() -> String? {
        return "id"
    }
}

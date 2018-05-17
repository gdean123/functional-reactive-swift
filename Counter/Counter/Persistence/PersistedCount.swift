import UIKit
import RxSwift
import RxRealm
import RealmSwift

class PersistedCount: Object {
    @objc dynamic var id = 0
    @objc dynamic var currentCount = 0

    static func create(currentCount: Int) -> PersistedCount {
        let count = PersistedCount()
        count.currentCount = currentCount
        return count
    }

    override class func primaryKey() -> String? { return "id" }
}

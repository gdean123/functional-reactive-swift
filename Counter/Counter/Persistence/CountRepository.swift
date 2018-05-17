import UIKit
import RxSwift
import RxRealm
import RealmSwift

class Count: Object {
    @objc dynamic var id = 0
    @objc dynamic var currentCount = 0

    static func create(currentCount: Int) -> Count {
        let count = Count()
        count.currentCount = currentCount
        return count
    }

    override class func primaryKey() -> String? { return "id" }
}

class CountRepository {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }

    func get() -> Observable<Int> {
        return Observable.from(object: realm.objects(Count.self).first!)
            .map({ count in
                return count.currentCount
            })
    }

    func update(count: Int) {
        try! realm.write {
            realm.add(Count.create(currentCount: count), update: true)
        }
    }
}

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
    let disposeBag: DisposeBag

    init(realm: Realm, disposeBag: DisposeBag) {
        self.realm = realm
        self.disposeBag = disposeBag
    }

    func get() -> Observable<Int> {
        return Observable.from(object: realm.objects(Count.self).first!)
            .map({ count in
                return count.currentCount
            })
    }

    func update(count: Observable<Int>) {
        count
            .map { currentCount in Count.create(currentCount: currentCount) }
            .subscribe(realm.rx.add(update: true, onError: { count, error in print("Error saving count") }))
            .disposed(by: disposeBag)
    }
}

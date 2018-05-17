import Foundation
import RxSwift
import RealmSwift

class PersistCountSink {
    let realm: Realm
    let count: Observable<Int>
    let disposeBag: DisposeBag

    init(realm: Realm, count: Observable<Int>, disposeBag: DisposeBag) {
        self.realm = realm
        self.count = count
        self.disposeBag = disposeBag
    }

    func listen() {
        count
            .subscribe(onNext: { count in
                self.update(count: count)
            })
            .disposed(by: disposeBag)
    }

    private func update(count: Int) {
        try! realm.write {
            realm.add(PersistedCount.create(currentCount: count), update: true)
        }
    }
}

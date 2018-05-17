import Foundation
import RxSwift
import RealmSwift

class PersistCountSink {
    let realm: Realm
    let count: Observable<Int>
    let disposeBag = DisposeBag()

    init(realm: Realm, count: Observable<Int>) {
        self.realm = realm
        self.count = count
    }

    func listen() {
        count
            .subscribe(onNext: { count in self.update(count: count) })
            .disposed(by: disposeBag)
    }

    private func update(count: Int) {
        try! realm.write {
            realm.add(PersistedCount.create(currentCount: count), update: true)
        }
    }
}

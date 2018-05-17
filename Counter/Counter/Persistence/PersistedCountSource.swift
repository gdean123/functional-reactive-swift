import RxSwift
import RealmSwift

class PersistedCountSource {
    let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func initial() -> Observable<Int> {
        return all().take(1)
    }

    func all() -> Observable<Int> {
        let count = find() ?? create(count: 0)

        return Observable
            .from(object: count)
            .map({ count in
                return count.currentCount
            })
    }

    private func find() -> PersistedCount? {
        return realm.objects(PersistedCount.self).first
    }

    private func create(count: Int) -> PersistedCount {
        let persistedCount = PersistedCount.create(currentCount: count)

        try! realm.write {
            realm.add(persistedCount, update: true)
        }

        return persistedCount
    }
}

import Quick
import Nimble
import RxSwift
import RealmSwift

@testable import Counter

class PersistCountSinkSpec: QuickSpec {
    override func spec() {
        var persistCountSink: PersistCountSink!

        var realm: Realm!
        var count: PublishSubject<Int>!
        var disposeBag: DisposeBag!

        beforeEach {
            disposeBag = DisposeBag()
            realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: UUID().uuidString))
            count = PublishSubject()

            persistCountSink = PersistCountSink(realm: realm, count: count, disposeBag: disposeBag)
        }

        describe("#listen") {
            beforeEach {
                persistCountSink.listen()
            }

            context("when a count is emitted") {
                beforeEach {
                    count.onNext(123)
                }

                it("writes the count to realm") {
                    let count = realm.objects(PersistedCount.self).first?.currentCount
                    expect(count).to(equal(123))
                }
            }
        }
    }
}

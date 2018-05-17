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

        beforeEach {
            realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: UUID().uuidString))
            count = PublishSubject()

            persistCountSink = PersistCountSink(realm: realm, count: count)
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

import Quick
import Nimble
import RxSwift
import RealmSwift

@testable import Counter

class PersistedCountSourceSpec: QuickSpec {
    override func spec() {
        var persistedCountSource: PersistedCountSource!
        var realm: Realm!
        var disposeBag: DisposeBag!

        beforeEach {
            realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: UUID().uuidString))
            disposeBag = DisposeBag()
            persistedCountSource = PersistedCountSource(realm: realm)
        }

        describe("#initial") {
            var emittedCounts: [Int]!

            beforeEach {
                write(count: 234)

                emittedCounts = []
                persistedCountSource.initial()
                    .subscribe(onNext: {count in emittedCounts.append(count)})
                    .disposed(by: disposeBag)
            }

            it("returns the initial value of count") {
                expect(emittedCounts).toEventually(equal([234]))
            }
        }

        describe("#all") {
            var emittedCounts: [Int]!

            beforeEach {
                emittedCounts = []
                persistedCountSource.all()
                    .subscribe(onNext: {count in emittedCounts.append(count)})
                    .disposed(by: disposeBag)
            }

            it("creates a count of 0 if one does not already exist") {
                expect(emittedCounts).toEventually(equal([0]))
            }

            it("streams all values of count") {
                write(count: 456)
                write(count: 789)
                expect(emittedCounts).toEventually(equal([0, 456, 789]))
            }
        }

        func write(count: Int) {
            try! realm.write {
                realm.add(PersistedCount.create(currentCount: count), update: true)
            }
        }
    }
}

import Foundation
import RxSwift
import RxCocoa

class Counter {
    private let didIncrementStream: PublishSubject<Void>
    private let didDecrementStream: PublishSubject<Void>
    private let initialCountStream: Observable<Int>

    init(initialCountStream: Observable<Int>) {
        self.didIncrementStream = PublishSubject()
        self.didDecrementStream = PublishSubject()
        self.initialCountStream = initialCountStream
    }

    func increment() {
        didIncrementStream.onNext(Void())
    }

    func decrement() {
        didDecrementStream.onNext(Void())
    }

    func countStream() -> Observable<Int> {
        return Observable
            .combineLatest(initialCountStream, localCount())
            .map { initialCount, localCount in
                initialCount + localCount
            }
    }

    func localCount() -> Observable<Int> {
        return countEvents()
            .startWith(0)
            .scan(0) { accumulator, currentValue in
                return accumulator + currentValue
        }
    }

    private func countEvents() -> Observable<Int> {
        return Observable.merge(
            didIncrementStream.map { 1 },
            didDecrementStream.map { -1 }
        )
    }
}

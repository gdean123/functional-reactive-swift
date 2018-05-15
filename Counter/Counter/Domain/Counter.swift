import Foundation
import RxSwift
import RxCocoa

class Counter {
    let didTapIncrementStream: PublishSubject<Void>
    let didTapDecrementStream: PublishSubject<Void>
    let countRelay: BehaviorRelay<String>
    private let disposeBag: DisposeBag

    init() {
        self.didTapIncrementStream = PublishSubject<Void>()
        self.didTapDecrementStream = PublishSubject<Void>()
        self.countRelay = BehaviorRelay<String>(value: "")
        self.disposeBag = DisposeBag()

        let countStream = Observable.merge(self.didTapIncrementStream.map { 1 }, self.didTapDecrementStream.map { -1 })
            .scan(0) {(accumulator, currentValue) in accumulator + currentValue }
            .map({ (count) in
                return String(count)
            })

        countStream
            .bind(to: countRelay)
            .disposed(by: disposeBag)
    }
}

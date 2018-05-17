import Foundation
import RxSwift
import RealmSwift

class PersistCountSink {
    let countRepository: CountRepository
    let count: Observable<Int>
    let disposeBag: DisposeBag

    init(countRepository: CountRepository, count: Observable<Int>, disposeBag: DisposeBag) {
        self.countRepository = countRepository
        self.count = count
        self.disposeBag = disposeBag
    }

    func listen() {
        count
            .subscribe(onNext: { count in
                self.countRepository.update(count: count)
            })
            .disposed(by: disposeBag)
    }
}

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    let application: Application

    override init() {
        application = Application()
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        print("the real app delegate!")
        self.application.run()
        return true
    }
}

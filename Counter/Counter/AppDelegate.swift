import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = CounterViewController()
        self.window!.makeKeyAndVisible()
        
        return true
    }
}

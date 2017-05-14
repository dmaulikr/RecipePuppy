import AlamofireNetworkActivityIndicator
import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityIndicatorManager.shared.completionDelay = 0.25
        NetworkActivityIndicatorManager.shared.isEnabled = true

        let rootViewController = RootViewController()

        let navigationController = UINavigationController(rootViewController: rootViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

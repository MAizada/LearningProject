import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var vc = CryptoListViewController()
        let presenter = CryptoListPresenter()
        presenter.view = vc
        vc.presenter = presenter
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        // Override point for customization after application launch.

        return true
    }
}


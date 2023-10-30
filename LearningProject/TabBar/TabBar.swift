
import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        generateTabBar()
        selectedIndex = 0
    }
    
    private func generateTabBar() {
        let home = (UIApplication.shared.delegate as? AppDelegate)?.cryptoListViewController
        let homeImage = UIImage(systemName: "house.fill")
        let homeTabBarItem = UITabBarItem(title: "", image: homeImage, tag: 0)
        
        
        let favorites = (UIApplication.shared.delegate as? AppDelegate)?.favoritesCryptoListViewController
        let favoritesImage = UIImage(systemName: "star.fill")
        let favoritesTabBarItem = UITabBarItem(title: "", image: favoritesImage, tag: 1)
        
    }
}
extension TabBarController: UITabBarControllerDelegate {
func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
}
}

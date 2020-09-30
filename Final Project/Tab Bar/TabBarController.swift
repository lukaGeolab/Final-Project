import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!
        let nav = generateNavController(vc: homeVC, title: "Home", image: UIImage(named: "home")!)
        let nav1 = generateNavController(vc: SearchTableViewController(), title: "Search", image: UIImage(named: "search")!)
        let nav2 = generateNavController(vc: FavoritesViewController(), title: "Favorites", image: UIImage(named: "favorite")!)
        let nav3 = generateNavController(vc: DownloadsViewController(), title: "Downloads", image: UIImage(named: "download")!)
        let nav4 = generateNavController(vc: UserViewController(), title: "User", image: UIImage(named: "user")!)
        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers = [nav, nav1, nav2, nav3, nav4]
    }
    
    private func generateNavController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.image = image
        return navController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(#function)
    }
}



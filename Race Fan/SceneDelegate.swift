//
//  SceneDelegate.swift
//  Race Fan
//
//  Created by Neal Siegrist on 12/30/22.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var tabBarController: UITabBarController?
    private var isDataRefreshNeeded = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        self.tabBarController = setupControllersAndNavigation()
        
        self.isDataRefreshNeeded = false
        DataManager.shared.fetchAllData()
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        reactivateCountdownTimers()
        
        if self.isDataRefreshNeeded {
            self.isDataRefreshNeeded = false
            DataManager.shared.fetchAllData()
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        self.isDataRefreshNeeded = true
    }
    
    private func reactivateCountdownTimers() {
        guard let homePageNC = self.tabBarController?.viewControllers?[0] as? UINavigationController else { return }
        guard let scheduleNC  = self.tabBarController?.viewControllers?[1] as? UINavigationController else { return }
        
        for controller in homePageNC.viewControllers {
            if let raceDetailVC = controller as? RaceDetailVC {
                raceDetailVC.startCountdownTimer()
            }
            
            if let homePageVC = controller as? HomePageVC {
                homePageVC.updateUI()
            }
        }
        
        if let raceDetailCountdown = scheduleNC.topViewController as? RaceDetailVC {
            raceDetailCountdown.startCountdownTimer()
        }
    }
    
    private func setupControllersAndNavigation() -> UITabBarController {
        let homePageNC = createNavigationController(viewController: HomePageVC(), systemImageName: "house")
        let scheduleNC = createNavigationController(viewController: ScheduleVC(), systemImageName: "calendar")
        let standingsNC = createNavigationController(viewController: StandingsVC(), systemImageName: "list.number")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homePageNC, scheduleNC, standingsNC]
        tabBarController.tabBar.tintColor = .red
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.selectedIndex = 0
        
        return tabBarController
    }
    
    private func createNavigationController(viewController vc: UIViewController, systemImageName imgName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.image = UIImage(systemName: imgName)?.imageWithoutBaseline()
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 5.0, left: 0, bottom: -5.0, right: 0)
        
        return navigationController
    }
}

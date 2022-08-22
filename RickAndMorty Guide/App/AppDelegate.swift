//
//  AppDelegate.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 14.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Alamofire Network Logger
        self.initAlamofireNetworkLogger()

        // Localize
        self.initLocalize()

        // Keyboard Manager
        self.initIQKeyboardManager()

        // start Coordinator
        self.startAppCoordinator()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("AppDelegateCycle -> applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("AppDelegateCycle -> applicationWillEnterForeground")
    }

    private func startAppCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window)
        self.window = window

        self.startFlowSplash()
    }

    func startFlowSplash() {
        self.appCoordinator.start()
    }

    func startFlowMain() {
        self.appCoordinator.startFlowMain()
    }
}


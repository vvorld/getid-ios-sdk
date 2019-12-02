//
//  AppDelegate.swift
//  Swift-Example
//
//  Created by Mikhail Akopov on 02.12.2019.
//  Copyright © 2019 GetID. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = ViewController()
        self.window = window
        return true
    }

}

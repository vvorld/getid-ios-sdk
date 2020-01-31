//
//  AppDelegate.swift
//  FormPrefill-Example
//
//  Created by Mikhail Akopov on 31.01.2020.
//  Copyright © 2020 GetID. All rights reserved.
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

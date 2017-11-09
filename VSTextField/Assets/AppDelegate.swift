//
//  AppDelegate.swift
//  VSTextField
//
//  Created by Dave Neff on 11/8/17.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = VSTextFieldExample()
    
    return true
  }

}

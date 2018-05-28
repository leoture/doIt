//
//  AppDelegate.swift
//  doIt
//
//  Created by jordhan leoture on 24/05/2018.
//  Copyright © 2018 jordhan leoture. All rights reserved.
//

import UIKit
import Intents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    INPreferences.requestSiriAuthorization { status in
      switch status {

      // User has not yet made a choice with regards to this application.
      case .notDetermined : print("not determined")

        // This application is not authorized to use Siri services.  Due
        // to active restrictions on Siri services, the user cannot change
      // this status, and may not have personally denied authorization.
      case .restricted : print("restricted")

        // User has explicitly denied authorization for this application, or
      // Siri services are disabled in Settings.
      case .denied : print("denied")

      // User has authorized this application to use Siri services.
      case .authorized : print("authorized")
      }
    }

    return true
  }

}


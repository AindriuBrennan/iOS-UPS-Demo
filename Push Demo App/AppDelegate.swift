//
//  AppDelegate.swift
//  Push Demo App
//
//  Created by shadowman on 24/01/2020.
//  Copyright © 2020 aerogear. All rights reserved.
//

import UIKit
import AeroGearPush

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //register the app with Unified Push Server
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // setup registration
        let registration = DeviceRegistration(serverURL: URL(string: "http://localhost:9999/")!)

        // attempt to register
        registration.register(
                clientInfo: { (clientDevice: ClientDeviceInformation!) in
                    // setup configuration
                    clientDevice.deviceToken = deviceToken
                    clientDevice.variantID = "7ac13452-f792-4820-abfe-840164928691"
                    clientDevice.variantSecret = "057571ef-f985-49f7-b117-81fc7f2cdc33"

                    // apply the token, to identify THIS device
                    let currentDevice = UIDevice()

                    // -- optional config --
                    // set some 'useful' hardware information params
                    clientDevice.operatingSystem = currentDevice.systemName
                    clientDevice.osVersion = currentDevice.systemVersion
                    clientDevice.deviceType = currentDevice.model
                },
                success: {
                    print("UnifiedPush Server registration succeeded")
                },
                failure: { (error: Error!) in
                    print("failed to register, error: \(error.localizedDescription)")
                }
        )
    }
    
    //handle push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    


}


//
//  AppDelegate.swift
//  GoodLogger-Sample
//
//  Created by Andrej Jasso on 27/08/2024.
//

import FirebaseCore
import UIKit
import FirebaseCrashlytics
import GoodLogger

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()

        return true
    }

}

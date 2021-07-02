//
//  AppDelegate.swift
//  SwiftReLearn
//
//  Created by runlong on 2021/5/20.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit
import JJException
@UIApplicationMain

//上架审核相关
//https://www.jianshu.com/p/6bedca6ab1ec
class AppDelegate: UIResponder, UIApplicationDelegate,JJExceptionHandle {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerJJException()
        RunTimeViewController.swizzle()
        return true
    }
    
    func registerJJException(){
        JJException.configExceptionCategory(.allExceptZombie)
        JJException.startGuard()
        JJException.register(self);
    }
        
    @objc func handleCrashException(_ exceptionMessage: String, extraInfo info: [AnyHashable : Any]?) {
        TMLog(#function)
        TMLog(exceptionMessage)
        TMLog(info?.debugDescription)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}


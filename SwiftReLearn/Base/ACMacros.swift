//  全局需要用到的常量
//  ACMacros.swift
//  SwiftReLearn
//
//  Created by runlong on 2021/5/24.
//  Copyright © 2021 JoyTomi. All rights reserved.
//


import Foundation
import UIKit
// 沙盒路径
public let kPATH_OF_APP_HOME = NSHomeDirectory()
public let kPATH_OF_TEMP = NSTemporaryDirectory()
public let kPATH_OF_DOCUMENT = kPATH_OF_APP_HOME + "/Documents"
public let kPATH_OF_CACHES = kPATH_OF_APP_HOME + "/Library/Caches"

// 设备相关
public let kUniqueString = ProcessInfo.processInfo.globallyUniqueString

public let kIsIphoneX: Bool = {
    var isphoneX = false
    if #available(iOS 11.0, *), let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets , safeAreaInsets.bottom > 0 {
        isphoneX = true
    }
    return isphoneX
}()
public let kIsPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//时间相关
/** 时间间隔 */
public let kHUDDuration = 1
/** 一天的秒数 */
public let kSecondsOfDay = (24 * 60 * 60)
/** 秒数 */
public func Seconds(_ days: Int) -> Int { return (kSecondsOfDay * days) }
/** 一天的毫秒数 */
public let kMillisecondsOfDay = (24 * 60 * 60 * 1000)
/** 毫秒数 */
public func Milliseconds(_ days: Int) -> Int { return kMillisecondsOfDay * (days) }

// 输出日志
public func TMLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("Log:\(fileName):(\(lineNum))-\(messsage)\n")
    #endif
}


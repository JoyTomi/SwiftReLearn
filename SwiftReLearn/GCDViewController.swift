//
//  GCDViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/8/9.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit

#warning("asd")
// MARK: 123
class GCDViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        let queue = DispatchQueue(label: "1", attributes: .concurrent)
        //        let queue2 = DispatchQueue(label: "2")
        TMLog("1")
        queue.async {
            TMLog("2")
        }
        
        queue.async {
            TMLog("3")
            //            Thread.sleep(forTimeInterval: 3)
            //            TMLog(Thread.current)
        }
        
        queue.asyncAfter(deadline: .now() + 3) {
            TMLog("4")
        }
        
        queue.async(flags: .barrier) {
            TMLog("barrier")
        }
        
        
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  KVOViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/6/28.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit

class KVOViewController: UIViewController {
    
    //swift中KVO 实现方法1
    //1、被监听属性前需要加关键字 @objc dynamic
    @objc dynamic var age:Int = 3
    
    //KVO实现方法2
    var model = KVOModel()
    var observer: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        //2、添加监听者
        self.addObserver(self, forKeyPath: "age", options: [.old,.new], context: nil)
        
        //方法2
        observer = model.observe(\KVOModel.name, options: [.old,.new], changeHandler: { model, change in
            TMLog("old\(change.oldValue)")
            TMLog("new\(change.newValue)")
        })
    }
    
    //3、实现以下方法
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        TMLog("oldkey\(change?[.oldKey])")
        TMLog("newKey\(change?[.newKey])")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.age = 33
        self.model.name = "kk"
    }
}


class KVOModel: NSObject {
    @objc dynamic var name: String = ""
}


import KVOController
extension KVOViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kvoController.observe(model, keyPath: "name", options: .new) { viewcontroller, model, change in
            TMLog(viewcontroller)
            TMLog(model)
            TMLog(change)
        }
    }
}

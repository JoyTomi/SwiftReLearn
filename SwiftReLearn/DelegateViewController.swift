//
//  DelegateViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/6/28.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit

class DelegateViewController: UIViewController {
    weak var testDelegate:TestDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.testDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TMLog(#function)
        testDelegate?.handleEvent?()
    }
}

extension DelegateViewController:TestDelegate {
    func handleEvent() {
        TMLog(#function)
    }
}

//1.定义协议
@objc  protocol TestDelegate:NSObjectProtocol {
    //如果 optional 必须加上@objc  否则报错
    @objc optional func handleEvent()
}

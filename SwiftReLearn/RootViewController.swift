//
//  RootViewController.swift
//  SwiftReLearn
//
//  Created by runlong on 2021/5/21.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.tm_hex(hexString: "#00C28A")
        let a = "".tm_getFormatterDurationToMS(9)
        TMLog(a)
        
        var b = "<p>123</p>"
        TMLog(b.tm_filterHTML())
        
        let img = UIImageView(image: UIImage.init(named: "test"))
        img.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        img.layer.shadowColor = UIColor.red.cgColor
        img.layer.shadowOffset = CGSize(width: 12, height: 12)
        img.layer.shadowOpacity = 0.5
        img.layer.shadowRadius = 10
        img.layer.cornerRadius = 12
        
        view.addSubview(img)
        UIView.cuttingImageView(imageView: img, direction: .bottomLeft, cornerRadii: 40.0, borderWidth: 1, borderColor: .red, backgroundColor: .clear)
        
//        img.addBlurEffect(style: .dark, alpha: 0.8)
//        let v = view.tm_blurView.setup(style: .extraLight, alpha: 0.4)
//        v.enable(isHidden: false)
        
        
        TMLog(String.transforNumberToString(num: NSNumber(value: 123)))
        
        TMLog("  ".isSpaceAll())
        let t = Test()
        t.title = "123title"
        TMLog(t.title)
        
        var s = TestStruct(index: 3)
        s.change(index: 4)
        TMLog(s)
        
        TMLog(AppUtils.infoDictionary)
    }
}

struct TestStruct {
    var index:Int
}

extension TestStruct {
    mutating func change(index:Int){
        self.index = index
    }
}


class Test {
    
}
//扩展添加属性方法
extension Test {
    var title: String? {
          get {
              return objc_getAssociatedObject(self, "title") as? String
          }
          
          set {
              objc_setAssociatedObject(self,
                                       "title", newValue,
                                       .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
          }
      }
}


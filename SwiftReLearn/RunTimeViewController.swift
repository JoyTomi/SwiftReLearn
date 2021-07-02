//
//  RunTimeViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/6/29.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit

class RunTimeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
}


//Objective-C 的 关联对象 ,向一个工程里所有的 view controllers 中添加一个 descriptiveName 属性，我们可以简单的使用 objc_get/setAssociatedObject()来填充其 get 和 set 块
extension RunTimeViewController {
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
    
    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}


//方法交叉(Method Swizzling)
//有时为了方便，也有可能是解决某些框架内的 bug，或者别无他法时，需要修改一个已经存在类的方法的行为。方法交叉可以让你交换两个方法的实现，相当于是用你写的方法来重载原有方法，并且还能够是原有方法的行为保持不变。

//注意测试方法加入了dynamic特性，否则是无法通过运行时进行交换的，viewDidAppear是继承Objective-C类获得的方法，本身就被修饰为dynamic，所以能被动态替换.
//
//这个例子中我们交叉 UIViewController 的 viewWillAppear 方法以打印出每一个在屏幕上显示的 view。方法交叉发生在 initialize 类方法调用时(如下代码所示)；替代的实现在 nsh_viewWillAppear 方法中

extension RunTimeViewController {
    
    @objc static func swizzle() -> Void {
        Swizzle(RunTimeViewController.self) {
            #selector(viewDidLoad) <-> #selector(myViewDidLoad)
            #selector(viewWillAppear(_:)) <-> #selector(myViewWillAppear(_:))
        }
    }
    
    @objc private func myViewDidLoad() {
        print(#function)
        myViewDidLoad()
    }
    
    @objc private func myViewWillAppear(_ animated: Bool) {
        print(#function)
        myViewWillAppear(animated)
    }
    
}

//
//  MultiThreadViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/6/30.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit
//http://www.cocoachina.com/articles/18749
class MultiThreadViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
}


//    1. Thread在三种多线程技术中是最轻量级的, 但需要自己管理线程的生命周期和线程同步. 线程同步对数据的加锁会有一定的系统开销.

extension MultiThreadViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        for i in 0...10 {
        //            Thread.detachNewThread {
        //                print("\(i) \(Thread.current)")
        //            }
        //        }
        //
        //        let obj = ObjectForThread()
        //        obj.threadTest()
        //        useWorkitem()
        self.groupQueue()
    }
}



class ObjectForThread {
    func threadTest() -> Void {
        let thread = Thread(target: self, selector: #selector(threadWorker), object: nil)
        thread.start()
        print("threadTest")
    }
    
    @objc func threadWorker() -> Void {
        print("threadWorker Run")
    }
    
}


//DispatchQueues
extension MultiThreadViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        self.deadLock()
    }
    
    private func deadLock(){
        //死锁
        let queue = DispatchQueue.main
        queue.sync {
            TMLog("sync同步函数向主队列添加任务会走造成死锁")
            //             应该使用异步或者子线程
        }
    }
    
    
    private func aboutQos(){
        //    从前到后，优先级从高到低:
        //    userInteractive
        //    userInitiated
        //    default
        //    utility
        //    background
        //    unspecified
        let queue = DispatchQueue(label: "com.qos",qos: .default)
        queue.async {
            
        }
    }
    
    //并发队列(Concurrent Queues)
    private func concurrent(){
        
        //        上述代码中添加了一个新参数`attributes`，当这个参数被赋予`concurrent`时，这个队列所有的任务将被同时执行。 如果你不加这个参数，那么队列默认就是串行执行的(serial)。 QoS不是必填项，在初始的时候完全可以忽略它。
        //
        let queue = DispatchQueue(label: "com.cpmcirremt.que",attributes: .concurrent)
        queue.async {
            
        }
        
        //        `attrubites`参数可以选择另外一个值:`initiallyInactive`。 通过定义为`initiallyInactive` 队列任务不会自动开始执行，需要开发者主动去触发。 为了展示这个特性，需要建一个`inactiveQueue `队列:
        let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility,attributes: .initiallyInactive)
        anotherQueue.async {
            
        }
        //      主动触发
        anotherQueue.activate()
        
        //        怎么创建一个既是初始不活跃又是并发的队列? 很简单，与之前提供`attributes`一个参数不同,这次给它赋值为一个包含两者的数组
        
        //        let anotherQueue2 = DispatchQueue(label: "com.appcoda.anotherQueue",qos: .userInitiated,attributes: [.concurrent,.initiallyInactive])
    }
    
    private func delayQueue(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
            
        }
    }
}


extension MultiThreadViewController {
    //workitem
    private func useWorkitem(){
        var value = 20
        let workItem = DispatchWorkItem {
            value+=1
        }
        //通知写在前面,不然多次调用会crash
        workItem.notify(queue: DispatchQueue.main) {
            TMLog("value = ，\(value)")
        }
        
        DispatchQueue.global().async(execute: workItem)
        TMLog("1\(value)")
        workItem.perform()
        TMLog("2\(value)")
        
        
    }
    
    //DispatchGroup
    private func groupQueue(){
        let item:DispatchWorkItem = DispatchWorkItem {
            print("开始吃饭")
            sleep(5)
            print("吃饭结束")
        }
        
        let item1:DispatchWorkItem = DispatchWorkItem {
            print("开始烧水")
            sleep(7)
            print("烧水结束")
        }
        
        let item2:DispatchWorkItem = DispatchWorkItem {
            print("开始煮饭")
            sleep(5)
            print("煮饭结束")
        }
        
        let item3:DispatchWorkItem = DispatchWorkItem {
            print("开始煮菜")
            sleep(6)
            print("煮菜结束")
        }
        
        let groupQueue:DispatchGroup = DispatchGroup.init()
        let queue:DispatchQueue = DispatchQueue.init(label: "queue", attributes:.concurrent)
        queue.async(group: groupQueue, execute: item1)
        queue.async(group: groupQueue, execute: item2)
        queue.async(group: groupQueue, execute: item3)
        groupQueue.notify(queue: DispatchQueue.main) {
            item.perform()
        }
    }
}

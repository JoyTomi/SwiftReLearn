//
//  RunLoopViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/8/16.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit

class RunLoopViewController: UIViewController {
    
    var codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    var time:Int = 60
    lazy var label = CATextLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.layer.addSublayer(label)
        label.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        label.foregroundColor = UIColor.white.cgColor
        label.backgroundColor = UIColor.black.cgColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.string = "23123"
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        codeTimer.setEventHandler {
            self.time -= 1
            TMLog(self.time)
            DispatchQueue.main.async {
                self.label.string = String(self.time)
            }
        }
        
        
        let timer = Timer.init(timeInterval: 1, repeats: true) { _ in
            self.time -= 1
            DispatchQueue.main.async {
                self.label.string = String(self.time)
            }
        }
        
        RunLoop.main.add(timer, forMode: .common)
        
        
//        RunLoop.current.add(timer, forMode: .common)
//        let port = Port()
//
//        RunLoop.main.add(port, forMode: .common)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TMLog("123")
//        self.codeTimer.activate()
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

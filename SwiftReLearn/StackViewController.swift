//
//  StackViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/8/10.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit
import SnapKit
class StackViewController: UIViewController {
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        layoutStackView()
    }
    
    func layoutStackView() {
        scrollView = UIScrollView()
        scrollView.frame = self.view.frame
        scrollView.backgroundColor = .brown
        view.addSubview(scrollView)
        
        
        stackView = stackViewWithAxis(axis: .vertical, alignment: .fill, distribution: .fill)
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
        
//        view.addSubview(stackView)
//        stackView.snp.makeConstraints { (make) in
//            make.center.equalTo(self.view)
//            make.left.equalTo(10)
//            make.right.equalTo(-10)
//
//        }
        let table = NSMapTable<AnyObject, AnyObject>(keyOptions: .objectPointerPersonality, valueOptions: .objectPointerPersonality)
        for i in 0..<43 {
            let label = createLabel()
            label.text = "\("哈哈")" + "\(i)"
            stackView.addArrangedSubview(label)
            label.snp.makeConstraints { (make) in
                make.height.greaterThanOrEqualTo(50)
            }
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
    
    func stackViewWithAxis(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
        return label
    }
}

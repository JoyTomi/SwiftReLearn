//
//  WCDBViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/7/16.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit
import WCDBSwift


class WCDBViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let database = Database(withPath:  kPATH_OF_DOCUMENT + "/sample.db")
        TMLog(kUniqueString)
        TMLog(database.path)
        try? database.create(table: "sampleTable", of: Sample.self)
        
        TMLog(database.isOpened)
        
        let samlple1 = Sample()
        samlple1.identifier = 2
        samlple1.desc = "123"
        try? database.insert(objects: samlple1, intoTable: "sampleTable")
        
        //
        
        guard let objects: [Sample] = try? database.getObjects(fromTable: "sampleTable",where:Sample.Properties.identifier == 2) else {
            return
        }
        
        TMLog(objects.map({ s in
            s.desc
        }))
        
        
        let object = Sample()
        object.desc = "sample_update"
        //Update
        try? database.update(table: "sampleTable",
                             on: Sample.Properties.desc,
                             with: object,
                             where: Sample.Properties.identifier == 1)
        try? database.delete(fromTable: "sampleTable",where: 1==1)
    }
    
}
//
//class Sample: TableCodable {
//    var identifier: Int? = nil
//    var description: String? = nil
//
//    enum CodingKeys: String, CodingTableKey {
//        typealias Root = Sample
//        static let objectRelationalMapping = TableBinding(CodingKeys.self)
//        case identifier
//        case description
//    }
//}

//
//
//class WCDBViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let database = Database(withPath: NSHomeDirectory() + "/Documents/sample.db")
//
//        try? database.create(table: "sampleTable", of: Sample.self)
//
//        let samlple1 = Sample()
//        samlple1.desc = "123"
//        try? database.insert(objects: samlple1, intoTable: "sampleTable")
//
//
//        let objects: [Sample] = try! database.getObjects(fromTable: "sampleTable")
//
//        let object = Sample()
//        object.desc = "sample_update"
//        //Update
//        try? database.update(table: "sampleTable",
//                               on: Sample.Properties.desc,
//                             with: object,
//                            where: Sample.Properties.identifier > 0)
//
//        try? database.delete(fromTable: "sampleTable")
//
//    }
//
//
//
//}

class Sample: TableCodable {
    var identifier: Int? = nil
    var desc: String? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case desc
    }
}


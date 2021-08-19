//
//  FMDBViewController.swift
//  SwiftReLearn
//
//  Created by JoyTomi on 2021/7/19.
//  Copyright © 2021 JoyTomi. All rights reserved.
//

import UIKit
import FMDB

class FMDBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let queue = FMDatabaseQueue.init(path: "")
        queue?.inDatabase({ db in
            
        })
        
        queue?.inTransaction { db, rollback in
            do {
                try db.executeUpdate("INSERT INTO myTable VALUES (?)", values: [1])
                try db.executeUpdate("INSERT INTO myTable VALUES (?)", values: [2])
                try db.executeUpdate("INSERT INTO myTable VALUES (?)", values: [3])

//                if whoopsSomethingWrongHappened {
//                    rollback.pointee = true
//                    return
//                }

                // etc ...
            } catch {
                rollback.pointee = true
                print(error)
            }
        }
        
        
        
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("test.sqlite")

        let database = FMDatabase(url: fileURL)

        guard database.open() else {
            print("Unable to open database")
            return
        }

        do {
            try database.executeUpdate("create table test(x text, y text, z text)", values: nil)
            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["a", "b", "c"])
            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["e", "f", "g"])

            let rs = try database.executeQuery("select x, y, z from test", values: nil)
            while rs.next() {
                if let x = rs.string(forColumn: "x"), let y = rs.string(forColumn: "y"), let z = rs.string(forColumn: "z") {
                    print("x = \(x); y = \(y); z = \(z)")
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }

        database.close()
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

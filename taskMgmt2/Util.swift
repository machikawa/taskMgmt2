//
//  Util.swift
//  taskMgmt2
//
//  Created by たうんりばー on 2022/02/27.
//

import Foundation

class Util {
    
    class func printer(str: String){
        print(str)
    }
    // これだと他所からコールできない
    func printer() {
        print("auto Printer")
    }
    class func prt() {
        print("classfunc")
    }
    
    static func stPrinter(str : String) {
        print("静的タイプのプリンター")
        print(str)
    }
    
}

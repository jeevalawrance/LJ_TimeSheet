//
//  TS_DashboardModel.swift
//  TimeSheet
//
//  Created by CPD on 11/17/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_DashboardModel: NSObject {
    
    var title = ""
    var subTitle = ""
    var image = ""
    
    static let sharedObject = TS_DashboardModel()
    
    let singletonModel = TS_DashboardModel.sharedObject


    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }

}

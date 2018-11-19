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
    
    let singleton = TS_DashboardModel.sharedObject



}

//
//  TaskList+CoreDataProperties.swift
//  TimeSheet
//
//  Created by Jeeva on 12/9/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskList> {
        return NSFetchRequest<TaskList>(entityName: "TaskList")
    }

    @NSManaged public var projectId: String?
    @NSManaged public var taskName: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var userType: Int16
    @NSManaged public var projectList: ProjectList?

}

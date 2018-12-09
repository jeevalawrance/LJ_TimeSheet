//
//  ProjectList+CoreDataProperties.swift
//  TimeSheet
//
//  Created by Jeeva on 12/9/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//
//

import Foundation
import CoreData


extension ProjectList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectList> {
        return NSFetchRequest<ProjectList>(entityName: "ProjectList")
    }

    @NSManaged public var address: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double
    @NSManaged public var placeName: String?
    @NSManaged public var projectName: String?
    @NSManaged public var userID: String?
    @NSManaged public var userType: Int16
    @NSManaged public var taskList: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for taskList
extension ProjectList {

    @objc(addTaskListObject:)
    @NSManaged public func addToTaskList(_ value: TaskList)

    @objc(removeTaskListObject:)
    @NSManaged public func removeFromTaskList(_ value: TaskList)

    @objc(addTaskList:)
    @NSManaged public func addToTaskList(_ values: NSSet)

    @objc(removeTaskList:)
    @NSManaged public func removeFromTaskList(_ values: NSSet)

}

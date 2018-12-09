//
//  User+CoreDataProperties.swift
//  TimeSheet
//
//  Created by Jeeva on 12/9/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userEmail: String?
    @NSManaged public var userIsVerified: Bool
    @NSManaged public var userName: String?
    @NSManaged public var userSurname: String?
    @NSManaged public var userType: Int16
    @NSManaged public var projectList: NSSet?

}

// MARK: Generated accessors for projectList
extension User {

    @objc(addProjectListObject:)
    @NSManaged public func addToProjectList(_ value: ProjectList)

    @objc(removeProjectListObject:)
    @NSManaged public func removeFromProjectList(_ value: ProjectList)

    @objc(addProjectList:)
    @NSManaged public func addToProjectList(_ values: NSSet)

    @objc(removeProjectList:)
    @NSManaged public func removeFromProjectList(_ values: NSSet)

}

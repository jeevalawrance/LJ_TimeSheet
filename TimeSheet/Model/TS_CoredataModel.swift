//
//  TS_CoredataModel.swift
//  TimeSheet
//
//  Created by CPD on 11/18/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import CoreData

class TS_CoredataModel: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createUser(name : String, surName:String, mailId : String, userType : Int, isNewUser : Bool) {
        
        if isNewUser{
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(mailId, forKey: "userEmail")
            newUser.setValue(name, forKey: "userName")
            newUser.setValue(surName, forKey: "userSurname")
            newUser.setValue(userType, forKey: "userType")
            newUser.setValue(false, forKey: "userIsVerified")
            //        newUser.setValue("1", forKey: "userType")
            do {
                try context.save()
                
                print("Success saving")
                
            } catch {
                print("Failed saving")
            }
        }
        else{
            
            var userDetail : NSManagedObject!
            
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            request.predicate = NSPredicate(format: "userEmail = %@", mailId)
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "userName") as! String)
                    
                    userDetail = data
                   
                    break
                }
                
            } catch {
                
                print("Failed")
            }
            if (userDetail != nil)
            {
                userDetail.setValue(true, forKey: "userIsVerified")
                
                do {
                    try context.save()
                    
                    print("Success saving")
                    
                } catch {
                    print("Failed saving")
                }
            }
        }
        
    }
    
    func retrieveUsers() {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "userName") as! String)
                
                let objUrl : URL = data.objectID.uriRepresentation()
                
                let objectId = objUrl.absoluteString
                
//                let objectId = appDelegate.persistentContainer.persistentStoreCoordinator.managedObjectID(forURIRepresentation:objUrl.uriRepresentation())
                
                print("object Id = \(objectId)")
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func retrieveParticularUser(email: String) -> NSManagedObject {
        
        var userDetail : NSManagedObject!
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "userEmail = %@", email)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
          
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "userName") as! String)
                
                userDetail = data
                
//                let objUrl : URL = data.objectID.uriRepresentation()
//
//                let objectId = objUrl.absoluteString
                
                break
            }
            
        } catch {
            
            print("Failed")
        }
        
        return userDetail
        
    }
    func allProjectsFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let emailType =  UserDefaults.standard.object(forKey: Constant.GlobalConstants.kEmailId)
        
        let data = self.retrieveParticularUser(email: emailType as! String)
        
        var objectId : String = ""
        
        if data != nil {
            let objUrl : URL = data.objectID.uriRepresentation()
            
            objectId = objUrl.absoluteString
        }

        let predicate = NSPredicate(format: "userID = %@", objectId)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProjectList")
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "projectName", ascending: true)
        
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        return fetchRequest
    }
    
    func allTasksFetchRequest(projectId : String) -> NSFetchRequest<NSFetchRequestResult> {
        
//        let data = self.retrieveParticularUser(email: projectId as! String)
//        
//        var objectId : String = ""
//        
//        if data != nil {
//            let objUrl : URL = data.objectID.uriRepresentation()
//            
//            objectId = objUrl.absoluteString
//        }
//        
        let predicate = NSPredicate(format: "userID = %@", projectId)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskList")
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "taskName", ascending: true)
        
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        return fetchRequest
    }
    func createNewProject(name : String) {
        
//        let data = self.retrieveParticularUser(email: Constant.GlobalConstants.kEmailId)
        
        let emailType =  UserDefaults.standard.object(forKey: Constant.GlobalConstants.kEmailId)

        let data = self.retrieveParticularUser(email: emailType as! String)
        
     
        if data != nil {
            let objUrl : URL = data.objectID.uriRepresentation()
            
            let objectId = objUrl.absoluteString
            
            let userType = data.value(forKey: "userType")
            
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "ProjectList", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(name, forKey: "projectName")
            newUser.setValue(objectId, forKey: "userID")
            newUser.setValue(userType, forKey: "userType")
            //        newUser.setValue("1", forKey: "userType")
            do {
                try context.save()
                
            } catch {
                print("Failed saving")
            }
        }
        else
        {
           
            
        }
        
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

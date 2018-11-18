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
    
    func createUser(name : String, surName:String, mailId : String, userType : Int) {
        
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(mailId, forKey: "userEmail")
        newUser.setValue(name, forKey: "userName")
        newUser.setValue(surName, forKey: "userSurname")
        newUser.setValue(userType, forKey: "userType")
        //        newUser.setValue("1", forKey: "userType")
        do {
            try context.save()
        } catch {
            print("Failed saving")
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
            }
            
        } catch {
            
            print("Failed")
        }
    }

    
    func retrieveParticularUser(email: String) -> Any {
        
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
                
                break
            }
            
        } catch {
            
            print("Failed")
        }
        
        return userDetail
        
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

//
//  TS_LoginViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/18/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import CoreData

class TS_LoginViewController: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var iconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        
//        let objCoredata = TS_CoredataModel()
//
//        let userDetail = objCoredata.retrieveParticularUser(email: self.txtEmail.text!)
//
        if(self.isValidEmail(email: self.txtEmail!.text) && (self.txtPassword.text!.characters.count) > 0)
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "userEmail = %@", self.txtEmail.text!)
            
            do {
                let profiles = try context.fetch(fetchRequest)
                assert(profiles.count < 2) // we shouldn't have any duplicates in CD
                
                if let profile = profiles.first as? User {
                    // we've got the profile already cached!
                    UserDefaults.standard.set(true, forKey: Constant.GlobalConstants.kLoggedIn)
                    
                    UserDefaults.standard.set(profile.userName, forKey: Constant.GlobalConstants.kFirstName)
                    UserDefaults.standard.set(profile.userSurname, forKey: Constant.GlobalConstants.kLastName)
                    UserDefaults.standard.set(profile.userEmail, forKey: Constant.GlobalConstants.kEmailId)
                    UserDefaults.standard.set(profile.userType, forKey: Constant.GlobalConstants.kUserType)
                    
                    appDelegate.settingRootViewcontroller()
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: "User not found", preferredStyle: .alert)
                    
                    
                    let action3 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
                        print("You've pressed the destructive");
                    }
                    alertController.addAction(action3)
                    self.present(alertController, animated: true, completion: nil)
                }
            } catch {
                // handle error
            }
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Please enter all fields", preferredStyle: .alert)
            
            
            let action3 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            alertController.addAction(action3)
            self.present(alertController, animated: true, completion: nil)
        }
       
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
    }
    
    func validate() -> Bool {
        
        if(self.isValidEmail(email: self.txtEmail!.text) && (self.txtPassword.text!.characters.count) > 0) {
            // Enable button
            return true
        } else {
            // Disable button
            
            return false
        }
    }
    //  MARK: UITextfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if self.validate()
        {
            self.signInAction((Any).self)
        }
        return true
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

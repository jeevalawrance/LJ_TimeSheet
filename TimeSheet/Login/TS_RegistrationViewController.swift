//
//  TS_RegistrationViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/14/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import DropDown
import CoreData

class TS_RegistrationViewController: UIViewController , PRGValidationFieldDelegate {
    
    @IBOutlet weak var nameField: PRGValidationField!
    
    @IBOutlet weak var surnameField: PRGValidationField!
    
    @IBOutlet weak var emailField: PRGValidationField!
    
    @IBOutlet weak var passwordField: PRGValidationField!
    
    @IBOutlet weak var confirmPasswordField: PRGValidationField!
    
    @IBOutlet weak var registerButton: UIButton!
        
    @IBOutlet var lblUserType: UILabel!
    @IBOutlet weak var categoryView : UIView!
    
    let dropDown = DropDown()
    
    var categoryType : NSString!
    
    var userType : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Registration"
        
        lblUserType.layer.cornerRadius = 5

        lblUserType.layer.borderWidth = 1
      
        lblUserType.layer.borderColor = UIColor.darkGray.cgColor
        
        
        passwordField.otherPasswordField = confirmPasswordField
        
        nameField.delegate = self
        surnameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
        
        // The view to which the drop down will appear on
        dropDown.anchorView = categoryView // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Contractor", "Sub-Contract", "Executive", "Supervisor"]

        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.categoryType = item as NSString
            self.lblUserType.text = "  \(item)"
            
            self.userType =  index
        }
        
        // Will set a custom width instead of the anchor view width
//        dropDownLeft.width = 200
    }
    @IBAction func dropDownAction(_ sender: Any) {

        dropDown.show()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func PRGValidationField(_field: PRGValidationField, didValidateWithResult result: Bool, andErrorMessage errorMessage: String?) {
        
        registerButton.isEnabled = nameField.isValid ?? false && surnameField.isValid ?? false && emailField.isValid ?? false && passwordField.isValid ?? false && confirmPasswordField.isValid ?? false
        
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        if(self.isValidEmail(email: self.emailField!.text)){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "userEmail = %@", self.emailField.text!)
            
            do {
                let profiles = try context.fetch(fetchRequest)
                
                if profiles.count > 0
                {
                    let alertController = UIAlertController(title: "Error", message: "Email already used", preferredStyle: .alert)
                    
                    
                    let action3 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
                        print("You've pressed the destructive");
                    }
                    alertController.addAction(action3)
                    self.present(alertController, animated: true, completion: nil)
                }
                else
                {
                    let objCoredata = TS_CoredataModel()
                    
                    let type = self.userType + 1
                    
                    objCoredata.createUser(name: self.nameField.text ?? "", surName: self.surnameField.text ?? "", mailId: self.emailField.text ?? "", userType: type, isNewUser: true)
                    
                    UserDefaults.standard.set(true, forKey: Constant.GlobalConstants.kRegistered)
                    
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//                    appDelegate.settingRootViewcontroller()
                    
                    let myVC : TS_VerificationViewController = self.storyboard?.instantiateViewController(withIdentifier: "verifyVC") as! TS_VerificationViewController
                    
                    self.navigationController?.pushViewController(myVC, animated: true)
                }
               
            } catch {
                // handle error
            }
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Please enter all valid fields", preferredStyle: .alert)
            
            
            let action3 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
                print("You've pressed the destructive");
            }
            alertController.addAction(action3)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
}

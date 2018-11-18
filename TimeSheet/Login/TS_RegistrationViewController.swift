//
//  TS_RegistrationViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/14/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import DropDown

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
        
        let objCoredata = TS_CoredataModel()
        
        objCoredata.createUser(name: self.nameField.text ?? "", surName: self.surnameField.text ?? "", mailId: self.emailField.text ?? "", userType: self.userType)
        
        UserDefaults.standard.set(true, forKey: Constant.GlobalConstants.kRegistered)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.mainRootViewController()
        appDelegate.settingRootViewcontroller()
        
    }
    
}

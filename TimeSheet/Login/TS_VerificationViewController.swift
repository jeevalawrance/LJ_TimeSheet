//
//  TS_VerificationViewController.swift
//  TimeSheet
//
//  Created by cpd on 11/29/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_VerificationViewController: UIViewController {

    @IBOutlet weak var txtOtp: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtOtp.delegate = self as? UITextFieldDelegate
        
        self.title = "Verification"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneEditing(_ sender: Any)
    {
        txtOtp.resignFirstResponder()
        
        let objCoredata = TS_CoredataModel()
        
        objCoredata.createUser(name: "", surName: "", mailId: "", userType: 0, isNewUser: false)
        
        
        let myVC : TS_LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! TS_LoginViewController
        
        self.navigationController?.pushViewController(myVC, animated: true)
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

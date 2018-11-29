//
//  TS_ProjectListViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/18/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_ProjectListViewController: UIViewController {
    @IBOutlet var lblNoProject: UILabel!
    
    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var btnAddProject: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Next Projects"
        
        self.btnAddProject.accessibilityLabel = "addproject";
        
        // Do any additional setup after loading the view.
        
        self.btnAddProject.layer.cornerRadius = 0.5;
        self.btnAddProject.layer.masksToBounds = true;
        self.btnAddProject.layer.borderWidth = 1.0;
        self.btnAddProject.layer.borderColor = UIColor.darkGray.cgColor
        
        let img = UIImage(named: "arrow-back")
        
        let left = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backAction))
        left.accessibilityLabel = "BackAction"
        self.navigationItem.leftBarButtonItem  = left
        
        
        let right = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(TS_ProjectListViewController.addProjectAction(_:)))
        right.accessibilityLabel = "RightButton"

        self.navigationItem.rightBarButtonItem  = right
        
        
    }
    
    // MARK: - USER ACTIONS
    @IBAction func addProjectAction(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Project name", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter project name"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            
            print(firstTextField.text ?? "")
            
            let textCount : Int = (firstTextField.text?.count)!
            
            
            if textCount > 0
            {
                let objCoredata = TS_CoredataModel()
                
                objCoredata.createNewProject(name: firstTextField.text ?? "")
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: "Project name should not empty", preferredStyle: UIAlertController.Style.alert)

                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {
                    (action : UIAlertAction!) -> Void in })
                
                alert.addAction(ok)
                
                self.present(alert, animated: true, completion: nil)

            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func backAction() {
        
        self.navigationController?.popViewController(animated: true)
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

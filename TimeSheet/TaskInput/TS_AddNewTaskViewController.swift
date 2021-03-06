//
//  TS_AddNewTaskViewController.swift
//  TimeSheet
//
//  Created by Jeeva on 11/30/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_AddNewTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtTaskName: UITextField!
    @IBOutlet weak var lblForceCount: UILabel!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet var btnAddTask: UIButton!

    var objProjectDetail : ProjectList!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Next Tasks"
        
        if objProjectDetail != nil {
            
            self.lblProjectName.text = objProjectDetail.projectName
        }
        
        // Do any additional setup after loading the view.
        
        self.btnAddTask.layer.cornerRadius = 0.5 //self.btnAddTask.frame.size.height / 2.0;
        self.btnAddTask.layer.masksToBounds = true;
        self.btnAddTask.layer.borderWidth = 1.0;
        self.btnAddTask.layer.borderColor = UIColor.darkGray.cgColor
        
        let img = UIImage(named: "arrow-back")
        
        let left = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backAction)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = left
        
//        let right = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(TS_TaskViewController.addTaskAction(_:))) // action:#selector(Class.MethodName) for swift 3
//        self.navigationItem.rightBarButtonItem  = right
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        txtTaskName!.resignFirstResponder()
        
        return true
    }
    
    // MARK:- BUTTON ACTION
    @IBAction func checkInAction(_ sender: Any)
    {
    }
    // MARK: - USER ACTIONS
    @IBAction func addTaskAction(_ sender: Any)
    {
        let textCount : Int = (self.txtTaskName.text?.count)!
        
        if textCount > 0
        {
            let objUrl : URL = objProjectDetail.objectID.uriRepresentation()
            
            let objectId = objUrl.absoluteString

            let objCoredata = TS_CoredataModel()
            
            let status = objCoredata.createNewTask(projectId: objectId, taskName: self.txtTaskName.text!)
            
            
            if status
            {
                self.backAction()
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Task unable to save", preferredStyle: UIAlertController.Style.alert)
                
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {
                    (action : UIAlertAction!) -> Void in })
                
                alert.addAction(ok)
                
                self.present(alert, animated: true, completion: nil)
            }
            
            //            objCoredata.createNewProject(name: txtProjectName.text ?? "")
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Task name should not empty", preferredStyle: UIAlertController.Style.alert)
            
            let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func taskListAction(_ sender: Any) {
    }
    @IBAction func projectListAction(_ sender: Any)
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "TaskInput", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "TS_ProjectListViewControllerVC") as! TS_ProjectListViewController
        myVC.fromView = ProjectType.FromTask
        self.navigationController?.pushViewController(myVC, animated: true)

//        ProjectType
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

//
//  TS_AddProjectTitleVC.swift
//  TimeSheet
//
//  Created by Jeeva on 12/3/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_AddProjectTitleVC: UIViewController,LocationViewProtocol, UITextFieldDelegate{
    
    @IBOutlet weak var txtProjectName: UITextField!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var btnAppProject: UIButton!
    var locationModel : TS_LocationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.txtProjectName.delegate = self
        
        self.btnAppProject.layer.cornerRadius = 0.5 //self.btnAddProject.frame.size.height / 2.0;
        self.btnAppProject.layer.masksToBounds = true;
        self.btnAppProject.layer.borderWidth = 1.0;
        self.btnAppProject.layer.borderColor = UIColor.darkGray.cgColor
        
        let img = UIImage(named: "arrow-back")
        
        let left = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backAction)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = left
        
    }
    func locationSelected(location : TS_LocationModel)
    {
        self.locationModel = location
        
        self.lblProjectName.text = location.locationName
//        print(location.locationName!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        txtProjectName.resignFirstResponder()
        
        return true
    }
    @objc func backAction() {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func addProjectAction(_ sender: Any) {
        let textCount : Int = (self.txtProjectName.text?.count)!
        
        if textCount > 0
        {
            let objCoredata = TS_CoredataModel()
            
            objCoredata.createNewProject(name: txtProjectName.text ?? "", location: self.locationModel!)
            
//            objCoredata.createNewProject(name: txtProjectName.text ?? "")
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Project name should not empty", preferredStyle: UIAlertController.Style.alert)
            
            let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func locationAction(_ sender: Any) {
        
        let myVC : TS_LocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationShareViewControllerVC") as! TS_LocationViewController
        myVC.delegate = self //as? AddProjectViewProtocol
        self.present(myVC, animated: true) {
            
        }
        
//        self.navigationController?.pushViewController(myVC, animated: true)
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

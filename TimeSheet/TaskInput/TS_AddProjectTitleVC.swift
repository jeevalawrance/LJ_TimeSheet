//
//  TS_AddProjectTitleVC.swift
//  TimeSheet
//
//  Created by Jeeva on 12/3/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_AddProjectTitleVC: UIViewController {
    
    @IBOutlet weak var txtProjectName: UITextField!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var btnAppProject: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.btnAppProject.layer.cornerRadius = 0.5 //self.btnAddProject.frame.size.height / 2.0;
        self.btnAppProject.layer.masksToBounds = true;
        self.btnAppProject.layer.borderWidth = 1.0;
        self.btnAppProject.layer.borderColor = UIColor.darkGray.cgColor
        
        let img = UIImage(named: "arrow-back")
        
        let left = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backAction)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = left
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        txtProjectName.resignFirstResponder()
        
        return true
    }
    @objc func backAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func locationAction(_ sender: Any) {
        
        let myVC : TS_LocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationShareViewControllerVC") as! TS_LocationViewController
        
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

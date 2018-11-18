//
//  TS_TaskViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/17/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_TaskViewController: UIViewController {
    @IBOutlet var lblNoTask: UILabel!
    
    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var btnAddTask: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Next Tasks"

        // Do any additional setup after loading the view.
        
        self.btnAddTask.layer.cornerRadius = 0.5;
        self.btnAddTask.layer.masksToBounds = true;
        self.btnAddTask.layer.borderWidth = 1.0;
        self.btnAddTask.layer.borderColor = UIColor.darkGray.cgColor
        
        let img = UIImage(named: "arrow-back")
        
        let left = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(backAction)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = left

        let right = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(TS_TaskViewController.addTaskAction(_:))) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = right
        

    }
    
    // MARK: - USER ACTIONS
    @IBAction func addTaskAction(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "TS_ProjectListViewControllerVC") as! TS_ProjectListViewController
        self.navigationController?.pushViewController(myVC, animated: true)
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

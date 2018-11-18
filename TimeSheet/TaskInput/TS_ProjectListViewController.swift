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

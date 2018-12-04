//
//  TS_TaskViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/17/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import CoreData

class TS_TaskViewController: UIViewController {
    
    var objProjectDetail : ProjectList!
    
    @IBOutlet var lblNoTask: UILabel!
    
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet weak var lblForceCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewProject: UIView!
    @IBOutlet weak var viewForce: UIView!

    @IBOutlet var btnAddTask: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    var context : NSManagedObjectContext?
    
    let objCoredata = TS_CoredataModel()

    
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
        
        context = appDelegate.persistentContainer.viewContext
        
        if objProjectDetail != nil {
            
            self.title = objProjectDetail.projectName

            let objUrl : URL = objProjectDetail.objectID.uriRepresentation()

           let objectId = objUrl.absoluteString
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: objCoredata.allTasksFetchRequest(projectId: objectId), managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchedResultsController?.delegate = self as? NSFetchedResultsControllerDelegate
            do {
                try fetchedResultsController?.performFetch()
            } catch {
                print(error)
            }
        }
        
        
        
        if fetchedResultsController?.fetchedObjects?.count == 0 || fetchedResultsController?.fetchedObjects == nil
        {
            viewProject.isHidden = true
            viewForce.isHidden = true
        }
        else
        {
            viewProject.isHidden = false
            viewForce.isHidden = false
        }
        self.tableView.reloadData()

    }
    
    // MARK: - USER ACTIONS
    @IBAction func addTaskAction(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "TS_AddNewTaskViewControllerVC") as! TS_AddNewTaskViewController
        self.navigationController?.pushViewController(myVC, animated: true)

//        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "TS_ProjectListViewControllerVC") as! TS_ProjectListViewController
//        self.navigationController?.pushViewController(myVC, animated: true)
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
extension TS_TaskViewController : UITableViewDataSource
{
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if fetchedResultsController == nil {
            return 0
        }
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if fetchedResultsController == nil {
            return 0
        }
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        
        
        if let project = fetchedResultsController?.object(at: indexPath) as? ProjectList {
            
            let title : String = project.projectName!
            
            
            cell.textLabel?.text = title
            
        }
        
        //        let headline = headlines[indexPath.row]
        //        cell.textLabel?.text = headline.title
        //        cell.detailTextLabel?.text = headline.text
        //        cell.imageView?.image = UIImage(named: headline.image)
        
        return cell
    }
    /*
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
     return .none
     }
     
     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
     return false
     }
     func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
     //        let movedObject = self.headlines[sourceIndexPath.row]
     //        headlines.remove(at: sourceIndexPath.row)
     //        headlines.insert(movedObject, at: destinationIndexPath.row)
     
     //        let movedObject = self.headlines[sourceIndexPath.row]
     //        headlines.remove(at: sourceIndexPath.row)
     //        headlines.insert(movedObject, at: destinationIndexPath.row)
     
     }
     */
}
extension TS_TaskViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let taskVC = self.storyboard?.instantiateViewController(withIdentifier: "taskInputVC") as! TS_TaskViewController
//        self.navigationController?.pushViewController(taskVC, animated: true)
        
    }
}

//
//  TS_TaskListViewController.swift
//  TimeSheet
//
//  Created by Jeeva on 12/8/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import CoreData


class TS_TaskListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var objProjectDetail : ProjectList!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    var context : NSManagedObjectContext?
    
    let objCoredata = TS_CoredataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        

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
//            viewProject.isHidden = true
        }
        
        self.tableView.reloadData()
        
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
extension TS_TaskListViewController : UITableViewDataSource
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        
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
}
extension TS_TaskListViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if fromView == ProjectType.FromDashBoard {
//
//            let taskVC = self.storyboard?.instantiateViewController(withIdentifier: "taskInputVC") as! TS_TaskViewController
//            taskVC.objProjectDetail = fetchedResultsController?.object(at: indexPath) as? ProjectList
//            self.navigationController?.pushViewController(taskVC, animated: true)
//        }
        
    }
    //    taskInputVC
}

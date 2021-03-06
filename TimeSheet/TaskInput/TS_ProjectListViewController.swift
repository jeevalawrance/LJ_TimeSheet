//
//  TS_ProjectListViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/18/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import CoreData

struct Headline {
    
    var id : Int
    var title : String
    var text : String
    var image : String
    
}
enum ProjectType : Int {
    case FromTask
    case FromTaskWise
    case FromDashBoard
//    case TaskInput
//    case Activity
}

class TS_ProjectListViewController: UIViewController {
    @IBOutlet var lblNoProject: UILabel!
    
    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var btnAddProject: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewProject: UIView!
    
    var fromView : ProjectType!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    var context : NSManagedObjectContext?

    let objCoredata = TS_CoredataModel()
    
//    var headlines = [
//        Headline(id: 1, title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id ornare tortor, quis dictum enim. Morbi convallis tincidunt quam eget bibendum. Suspendisse malesuada maximus ante, at molestie massa fringilla id.", image: "Apple"),
//        Headline(id: 2, title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non, finibus et diam. Morbi et felis a lacus pharetra blandit.", image: "Banana"),
//        Headline(id: 3, title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc in ipsum vehicula accumsan quis sit amet quam. Sed vel feugiat eros.", image: "Cantaloupe"),
//        ]
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Next Projects"
        
        self.btnAddProject.accessibilityLabel = "addproject";
        
//        self.tableView.isEditing = true
        
        context = appDelegate.persistentContainer.viewContext
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: objCoredata.allProjectsFetchRequest(), managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController?.delegate = self as? NSFetchedResultsControllerDelegate
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print(error)
        }
        
        if fetchedResultsController?.fetchedObjects?.count == 0 || fetchedResultsController?.fetchedObjects == nil
        {
            viewProject.isHidden = true
        }
        
        self.tableView.reloadData()

    }

    // MARK: - USER ACTIONS
    @IBAction func addProjectAction(_ sender: Any)
    {
        
        let taskVC = self.storyboard?.instantiateViewController(withIdentifier: "AppProjectTitleVC") as! TS_AddProjectTitleVC
        self.navigationController?.pushViewController(taskVC, animated: true)

        
        return
        
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
                
//                objCoredata.createNewProject(name: firstTextField.text ?? "")
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
    
    //MARK: NSFetchedResultsController Delegate Functions
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case NSFetchedResultsChangeType.insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: UITableView.RowAnimation.fade)
            break
        case NSFetchedResultsChangeType.delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: UITableView.RowAnimation.fade)
            break
        case NSFetchedResultsChangeType.move:
            break
        case NSFetchedResultsChangeType.update:
            break
        default:
            break
        }
    }
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .delete {
        }
        
        switch editingStyle {
        case .delete:
            context!.delete(fetchedResultsController?.object(at: indexPath as IndexPath) as! ProjectList)
            do {
                try context!.save()
            } catch {
                print(error)
            }
        case .none: break
            
        case .insert: break
            
        }
        
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case NSFetchedResultsChangeType.insert:
            tableView.insertRows(at: NSArray(object: newIndexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
            break
        case NSFetchedResultsChangeType.delete:
            tableView.deleteRows(at: NSArray(object: indexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
            break
        case NSFetchedResultsChangeType.move:
            tableView.deleteRows(at: NSArray(object: indexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
            tableView.insertRows(at: NSArray(object: newIndexPath!) as! [IndexPath], with: UITableView.RowAnimation.fade)
            break
        case NSFetchedResultsChangeType.update:
            tableView.cellForRow(at: indexPath! as IndexPath)
            break
        default:
            break
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
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

extension TS_ProjectListViewController : UITableViewDataSource
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
extension TS_ProjectListViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if fromView == ProjectType.FromDashBoard {
         
            let taskVC = self.storyboard?.instantiateViewController(withIdentifier: "taskInputVC") as! TS_TaskViewController
            taskVC.objProjectDetail = fetchedResultsController?.object(at: indexPath) as? ProjectList
            self.navigationController?.pushViewController(taskVC, animated: true)
        }
        
    }
//    taskInputVC
}

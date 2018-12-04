//
//  TS_DashboardViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/16/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

enum DashBoardMenu : Int {
    case SiteWise = 0
    case TaskWise
    case TaskInput
    case Activity
}
struct DashBoardMenuType {
    
    var id : Int
    var title : String
    var subTitle : String
    var image : String
    
}

class TS_DashboardViewController: UIViewController {
    
    var dashArray : NSMutableArray = []
    
//    var dashArray = [[String: String]]()


    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dashboard"
        
//        self.dashArray = [["title": "Site-Wise", "subTitle": "List Report", "image" : "sitewise"],
//                          ["title": "Task-Wise", "subTitle": "List Report", "image" : "chart"],
//                          ["title": "Task Input", "subTitle": "Work Input", "image" : "task"],
//                          ["title": "Activity", "subTitle": "Workers activity", "image" : "Activity"]]
        
        let userType : Int = UserDefaults.standard.object(forKey: Constant.GlobalConstants.kUserType) as! Int
        
        switch userType {
        case 1:
            
            self.dashArray = [
                DashBoardMenuType(id: DashBoardMenu.SiteWise.rawValue, title: "Site-Wise", subTitle: "List Report", image: "sitewise"),
                DashBoardMenuType(id: DashBoardMenu.TaskWise.rawValue, title: "Task-Wise", subTitle: "List Report", image: "chart"),
                DashBoardMenuType(id: DashBoardMenu.TaskInput.rawValue, title: "Task Input", subTitle: "Work Input", image: "task"),
                DashBoardMenuType(id: DashBoardMenu.Activity.rawValue, title: "Activity", subTitle: "Workers activity", image: "Activity"),
                
            ]
            break
        case 2:
            
            self.dashArray = [
                DashBoardMenuType(id: DashBoardMenu.SiteWise.rawValue, title: "Site-Wise", subTitle: "List Report", image: "sitewise"),
                DashBoardMenuType(id: DashBoardMenu.TaskWise.rawValue, title: "Task-Wise", subTitle: "List Report", image: "chart"),
                DashBoardMenuType(id: DashBoardMenu.TaskInput.rawValue, title: "Task Input", subTitle: "Work Input", image: "task"),
                DashBoardMenuType(id: DashBoardMenu.Activity.rawValue, title: "Activity", subTitle: "Workers activity", image: "Activity"),
                
            ]
            break
        case 3:
            
            self.dashArray = [
                DashBoardMenuType(id: DashBoardMenu.SiteWise.rawValue, title: "Site-Wise", subTitle: "List Report", image: "sitewise"),
                DashBoardMenuType(id: DashBoardMenu.TaskWise.rawValue, title: "Task-Wise", subTitle: "List Report", image: "chart"),
                DashBoardMenuType(id: DashBoardMenu.TaskInput.rawValue, title: "Task Input", subTitle: "Work Input", image: "task"),
                DashBoardMenuType(id: DashBoardMenu.Activity.rawValue, title: "Activity", subTitle: "Workers activity", image: "Activity"),
                
            ]
            break
        case 4:
            
            self.dashArray = [
                DashBoardMenuType(id: DashBoardMenu.SiteWise.rawValue, title: "Site-Wise", subTitle: "List Report", image: "sitewise"),
                DashBoardMenuType(id: DashBoardMenu.TaskWise.rawValue, title: "Task-Wise", subTitle: "List Report", image: "chart"),
                DashBoardMenuType(id: DashBoardMenu.TaskInput.rawValue, title: "Task Input", subTitle: "Work Input", image: "task"),
                DashBoardMenuType(id: DashBoardMenu.Activity.rawValue, title: "Activity", subTitle: "Workers activity", image: "Activity"),
                
            ]
            break
        default:
            
            self.dashArray = [
                DashBoardMenuType(id: DashBoardMenu.SiteWise.rawValue, title: "Site-Wise", subTitle: "List Report", image: "sitewise"),
                DashBoardMenuType(id: DashBoardMenu.TaskWise.rawValue, title: "Task-Wise", subTitle: "List Report", image: "chart"),
                DashBoardMenuType(id: DashBoardMenu.TaskInput.rawValue, title: "Task Input", subTitle: "Work Input", image: "task"),
                DashBoardMenuType(id: DashBoardMenu.Activity.rawValue, title: "Activity", subTitle: "Workers activity", image: "Activity"),
                
            ]
        }
        
        


//        print("\(dashArray)")
//        let img = UIImage(named: "signout")
        
        let signout = UIBarButtonItem(title: "Signout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(sinOutAction))
        
//        let right = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(sinOutAction)) //
        
        self.navigationItem.rightBarButtonItem  = signout
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func sinOutAction()  {
        
        let alert = UIAlertController(title: "Confirm", message: "Are you sure do you want signout?", preferredStyle: UIAlertController.Style.alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            appDelegate.settingLandingViewcontroller()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed the destructive");
        }
        
        alert.addAction(cancel)

        alert.addAction(yes)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let screenWidth : CGFloat = UIScreen.main.bounds.size.width / 2.0 - 10

            flowLayout.itemSize = CGSize(width: screenWidth , height: screenWidth)
//            flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: 120)
        }
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
extension TS_DashboardViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dashArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboard_cell_id", for: indexPath) as! TS_DashboardCellCollectionViewCell
//        let dict = self.dashArray[indexPath.row]
//        cell.lblTitle.text = dict["title"]
//        cell.lblSubTitle.text = dict["subTitle"]
//
//        let image: UIImage = UIImage(named: dict["image"] ?? "chart")!
//        cell.image.image = image

        
        let headline : DashBoardMenuType = self.dashArray[indexPath.row] as! DashBoardMenuType
        cell.lblTitle.text = headline.title
        cell.image.image = UIImage(named: headline.image)
        cell.lblSubTitle.text = headline.subTitle

        return cell
    }
}

extension TS_DashboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
        
        let headline : DashBoardMenuType = self.dashArray[indexPath.row] as! DashBoardMenuType

        if headline.id == DashBoardMenu.TaskInput.rawValue {
         
            let storyboard:UIStoryboard = UIStoryboard(name: "TaskInput", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "TS_ProjectListViewControllerVC") as! TS_ProjectListViewController
            myVC.fromView = ProjectType.FromDashBoard
            self.navigationController?.pushViewController(myVC, animated: true)
        }
        
    }
}

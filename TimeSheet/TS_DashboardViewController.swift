//
//  TS_DashboardViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/16/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_DashboardViewController: UIViewController {
    
//    var dashArray : NSMutableArray = []
    
    var dashArray = [[String: String]]()


    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dashboard"
        
        self.dashArray = [["title": "Site-Wise", "subTitle": "List Report", "image" : "sitewise"],
                          ["title": "Task-Wise", "subTitle": "List Report", "image" : "chart"],
                          ["title": "Task Input", "subTitle": "Work Input", "image" : "task"],
                          ["title": "Activity", "subTitle": "Workers activity", "image" : "Activity"]]

//        print("\(dashArray)")
        
        // Do any additional setup after loading the view.
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
        let dict = self.dashArray[indexPath.row]
        
        cell.lblTitle.text = dict["title"]
        cell.lblSubTitle.text = dict["subTitle"]

        let image: UIImage = UIImage(named: dict["image"] ?? "chart")!
        cell.image.image = image
        return cell
    }
}

extension TS_DashboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
        
        let storyboard:UIStoryboard = UIStoryboard(name: "TaskInput", bundle: nil)
//        let navigationController : UINavigationController = storyboard.instantiateViewController(withIdentifier: "mainRootNav") as! UINavigationController

//        let taskVC = storyboard.instantiateViewController(withIdentifier: "taskInputVC") as! TS_TaskViewController
//
//        self.navigationController?.pushViewController(taskVC, animated: true)
        
        
        let myVC = storyboard.instantiateViewController(withIdentifier: "TS_ProjectListViewControllerVC") as! TS_ProjectListViewController
        self.navigationController?.pushViewController(myVC, animated: true)
        
    }
}

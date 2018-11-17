//
//  TS_DashboardViewController.swift
//  TimeSheet
//
//  Created by CPD on 11/16/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_DashboardViewController: UIViewController {
    
    var dashArray : NSMutableArray = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dashboard"
        
//        self.dashArray

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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboard_cell_id", for: indexPath) as! TS_DashboardCellCollectionViewCell
      //  cell.lblTitle.text = String(indexPath.row + 1)
        return cell
    }
}

extension TS_DashboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}

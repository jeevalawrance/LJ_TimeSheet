//
//  TS_DashboardCellCollectionViewCell.swift
//  TimeSheet
//
//  Created by CPD on 11/16/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit

class TS_DashboardCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubTitle: UILabel!
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var viewShadow: UIView!
    @IBOutlet var viewTop: UIView!
    
    override func awakeFromNib() {
        self.viewTop.backgroundColor = UIColor.white
        self.viewShadow.layer.cornerRadius = 10
        self.viewShadow.layer.shadowOffset = CGSize(width: 2, height: 6) //CGSizeMake(2, 6)
//        self.viewShadow.layer.shadowRadius = 2;
//        self.viewShadow.layer.shadowOpacity = 0.3;
//        self.viewShadow.layer.shadowColor = UIColor.white.cgColor
//        self.viewShadow.backgroundColor = UIColor.black;
//        self.viewShadow.layer.cornerRadius = self.viewContainer.layer.cornerRadius+2;
        //        self.viewShadow.layer.shadowColor = UIColor(white: 0.0, alpha: 0.3) as! CGColor

        self.viewContainer.layer.cornerRadius = 10;
        
        
        self.viewShadow.layer.applySketchShadow(
            color: .white,
            alpha: 0.3,
            x: 0,
            y: 0,
            blur: 4,
            spread: 0)

        
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

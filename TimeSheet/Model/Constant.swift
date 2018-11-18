
import UIKit

enum UserType : Int {
    case Contractor
    case SubContractor
    case Executive
    case Supervisor
}

class Constant: NSObject {
    
    struct GlobalConstants {
        
        
        // GLOBLE COLOR DEFINE
        
        static let kBackGroundColor: UIColor = UIColor(red: 53.0/255.0, green: 126.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
        static let kNavigationBarColor: UIColor = UIColor(red: 0.407, green: 0.416, blue: 45.901, alpha: 1.0)//    0.407, 0.416, 45.901
        
        static let kNavigationTintColor: UIColor = UIColor.white

        static let kDashBoard: UIColor = UIColor.white


        
        // Check Device IPHONE
        
//        static let kIphone_4s : Bool =  (UIScreen.mainScreen().bounds.size.height == 480)
//
//        static let kIphone_5 : Bool =  (UIScreen.mainScreen().bounds.size.height == 568)
//
//        static let kIphone_6 : Bool =  (UIScreen.mainScreen().bounds.size.height == 667)
//
//        static let kIphone_6_Plus : Bool =  (UIScreen.mainScreen().bounds.size.height == 736)
        
    
        
        // Response searchList
        
        static let kRegistered                     =    "Registered"
        static let kFirstName                     =    "FirstName"
        static let kLastName                      =    "LastName"
        static let kOrganizationId                =    "OrganisationId"
        static let kIndividualID                  =    "IndividualId"
        static let kOrganizationName              =    "OrganisationName"
        static let kText                          =    "text"
        static let kID                            =    "Id"
        
        static let kOrganizationFullName          =    "FullName"
        
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//    view.backgroundColor = UIColorFromRGB(0x209624)
    
}

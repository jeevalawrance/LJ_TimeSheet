//
//  TS_LocationViewController.swift
//  TimeSheet
//
//  Created by Jeeva on 12/3/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class TS_LocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var heightMapviewConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblLocationNearby: UITableView!
    
//    @property (weak, nonatomic) IBOutlet UIView *viewMapSettings;
//    @property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
//    @property (weak, nonatomic) IBOutlet UILabel *lblMapSettings;
//    @property (weak, nonatomic) IBOutlet UIButton *btnCloseMapSettings;
//    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewBottomConstraint;
    
    let locationManager = CLLocationManager()
    let userCurrentLocation : CLLocation = CLLocation.init(latitude: 25.276987, longitude: 55.296249)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
    }
    // With Alamofire
    func fetchNearestLocation(){//(completion: @escaping ([RemoteRoom]?) -> Void) {
        
        let strUrl = String(format: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=5000&sensor=true&key=%@",(userCurrentLocation.coordinate.latitude),userCurrentLocation.coordinate.longitude,Constant.GlobalConstants.kGoogleServerKey)
        //        NSString *strUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=5000&sensor=true&key=%@",userCurrentLocation.coordinate.latitude,userCurrentLocation.coordinate.longitude,kGoogleServerKey];

        guard let url = URL(string: strUrl) else {
//            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: ["include_docs": "true"])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
//                    print("Error while fetching remote rooms: \(String(describing: response.result.error)")
//                        completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let rows = value["rows"] as? [[String: Any]] else {
                        print("Malformed data received from fetchAllRooms service")
//                        completion(nil)
                        return
                }
                
//                let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
//                completion(rooms)
        }
    }
    
    /*
    // With URLSession
    public func fetchAllRooms(){//(completion: @escaping ([RemoteRoom]?) -> Void) {
        
//        NSString *strUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=5000&sensor=true&key=%@",userCurrentLocation.coordinate.latitude,userCurrentLocation.coordinate.longitude,kGoogleServerKey];

        guard let url = URL(string: "http://localhost:5984/rooms/_all_docs?include_docs=true") else {
            completion(nil)
            return
        }
        
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = urlSession.dataTask(with: urlRequest)
        { (data, response, error) -> Void in
            guard error == nil else {
                print("Error while fetching remote rooms: \(String(describing: error)")
                    completion(nil)
                return
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Nil data received from fetchAllRooms service")
                    completion(nil)
                    return
            }
            
            guard let rows = json?["rows"] as? [[String: Any]] else {
                print("Malformed data received from fetchAllRooms service")
                completion(nil)
                return
            }
            
            let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
            completion(rooms)
        }
        
        task.resume()
    }
    */
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    @IBAction func cancelAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK:- WEBSERVICE
    
    /*
    -(void)nearestWS
    {
    
    [self showActivity];
    
    if([CommonFunction isActiveInternet])
    {
    NSString *strUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=5000&sensor=true&key=%@",userCurrentLocation.coordinate.latitude,userCurrentLocation.coordinate.longitude,kGoogleServerKey];
    
    [self selectedLocationApi:currentLocationAnnotation.coordinate withUrl:strUrl completionHandler:^(NSArray *places) {
    
    if (places.count > 0) {
    
    
    if(nearByDetails.count > 2)
    {
    [nearByDetails removeObjectsInRange:NSMakeRange(2, nearByDetails.count-2)];
    
    }
    for (NSDictionary *place in places) {
    
    
    NSString *iconUrl=@"";// = [self getPhotosURL:place[@"photos"]];
    
    //                    if ([place[@"photos"] count]>0) {
    //
    //                        iconUrl = [self getPhotosURL:[place[@"photos"] lastObject]];
    //                    }
    
    NSDictionary *location = [place[@"geometry"] objectForKey:@"location"];
    
    NSString *LocId= place[@"id"];
    
    NSString *name;
    
    if (place[@"name"]) {
    
    name = place[@"name"];
    }
    else{
    name=place[@"vicinity"];
    }
    
    NearLocation *objLocation =[[NearLocation alloc] initWithImageName:iconUrl title:name withLatitude:[location[@"lat"] doubleValue] withLongtitude:[location[@"lng"] doubleValue] withLocationId:LocId withAddress:place[@"vicinity"]];
    // do something with the icon URL
    
    [nearByDetails addObject:objLocation];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
    //When json is loaded stop the indicator
    
    //                    [CommonFunction removeLoaderFromViewController:self];
    
    [self.tblLocationNearby setHidden:NO];
    [self.tblRecentSearch setHidden:YES];
    
    [self.tblLocationNearby reloadData];
    
    [self hideActivity];
    
    [self getAddressFromCordinate:currentLocationAnnotation.coordinate];
    
    });
    
    }
    else{
    [CommonFunction removeLoaderFromViewController:self];
    
    }
    }];
    }
    else{
    //                    [CommonFunction removeLoaderFromViewController:self];
    
    [self hideActivity];
    
    [CommonFunction displayTheToastWithMsg:@"No internet connection !" duration:1.5];
    
    }
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TS_LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("\(lat),\(long)")
//            lookUpCurrentLocation { geoLoc in
//                print(geoLoc?.locality ?? "unknown Geo location")
//            }
            
            self.fetchNearestLocation()
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

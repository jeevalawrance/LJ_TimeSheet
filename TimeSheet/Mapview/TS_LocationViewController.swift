//
//  TS_LocationViewController.swift
//  TimeSheet
//
//  Created by Jeeva on 12/3/18.
//  Copyright © 2018 Jeeva. All rights reserved.
//

import UIKit
import MapKit

class TS_LocationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

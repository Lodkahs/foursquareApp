//
//  DetailsVC.swift
//  foursquare
//
//  Created by Andrew  on 3/9/23.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
    
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var detailsPlacenameLabel: UILabel!
    
    @IBOutlet weak var detailsTypeLabel: UILabel!
    
    @IBOutlet weak var detailsCommentLabel: UILabel!
    
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var chosenPlaceID = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceID)
        query.findObjectsInBackground { objects, error in
            
            if error != nil {
                //
            } else {
                print(objects)
            }
        }
    }
    

}

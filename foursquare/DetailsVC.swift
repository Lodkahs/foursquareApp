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
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromParse()
        
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceID)
        query.findObjectsInBackground { objects, error in
            
            if error != nil {
                //
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenPlaceObject = objects![0]
                        
                        if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                            self.detailsPlacenameLabel.text = placeName
                        }
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.detailsTypeLabel.text = placeType
                        }
                        if let placeComment = chosenPlaceObject.object(forKey: "comment") as? String {
                            self.detailsCommentLabel.text = placeComment
                        }
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { data, error in
                                if error == nil {
                                    if data != nil {
                                        self.detailsImageView.image = UIImage(data: data!)
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    
                }
            }
        }
    }
    

}

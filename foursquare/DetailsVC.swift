//
//  DetailsVC.swift
//  foursquare
//
//  Created by Andrew  on 3/9/23.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    
    
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
        detailsMapView.delegate = self
        
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
                        
                        //object operation
                        
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
                        
                        //map operations
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.detailsMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.detailsPlacenameLabel.text!
                        annotation.subtitle = self.detailsTypeLabel.text!
                        self.detailsMapView.addAnnotation(annotation)
                        
                    }
                    
                    
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseID = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: chosenLatitude, longitude: chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks {
                    
                    if placemark.count > 0 {
                        
                        let mkPlacemark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlacemark)
                        mapItem.name = self.detailsPlacenameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }

}

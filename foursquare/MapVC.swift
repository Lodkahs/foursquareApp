//
//  MapVC.swift
//  foursquare
//
//  Created by Andrew  on 3/8/23.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
    }
    
    @objc func saveButtonClicked() {
        //parse
        
    }
    
    @objc func backButtonClicked() {
        //navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true)
    }
    

    

}

//
//  DetailsVC.swift
//  foursquare
//
//  Created by Andrew  on 3/9/23.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {
    
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var detailsPlacenameLabel: UILabel!
    
    @IBOutlet weak var detailsTypeLabel: UILabel!
    
    @IBOutlet weak var detailsCommentLabel: UILabel!
    
    @IBOutlet weak var detailsMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

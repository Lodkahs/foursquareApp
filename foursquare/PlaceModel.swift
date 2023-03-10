//
//  PlaceModel.swift
//  foursquare
//
//  Created by Andrew  on 3/10/23.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    
    private init() {
        
    }
}

//
//  PlacesVC.swift
//  foursquare
//
//  Created by Andrew  on 3/8/23.
//

import UIKit

class PlacesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked() {
        //segue
    }
    

    

}

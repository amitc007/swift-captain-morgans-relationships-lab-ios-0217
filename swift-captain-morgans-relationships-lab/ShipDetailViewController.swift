//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Edmund Holderbaum on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class ShipDetailViewController: UIViewController {
    
    var ship: Ship? = nil
    
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var pirateNameLabel: UILabel!
    @IBOutlet weak var propulsionTypeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("\(ship?.name ?? "nil" )")
        shipNameLabel.text = ship?.name
        pirateNameLabel.text = ship?.pirate?.name
        propulsionTypeLabel.text = ship?.engine?.engineType
    }

}

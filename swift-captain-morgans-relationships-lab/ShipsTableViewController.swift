//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Edmund Holderbaum on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class ShipsTableViewController: UITableViewController {
    
    let singleton = DataStore.shared
    var pirate: Pirate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let ships = pirate?.ships?.count else {return 10}
        return ships
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell", for: indexPath)

        // Configure the cell...
        guard let ships = pirate?.ships else {print ("no pirate"); return cell}
        let shipsArray = Array(ships)
        guard let ship = shipsArray[indexPath.row] as? Ship else {print("could not get ship"); return cell}
        cell.textLabel?.text = ship.name

        return cell
    }

        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepare(for segue: UIStoryboardSegue, sender: UITableViewCell) {
        guard let shipName = sender.textLabel?.text else {print ("something wrong w ship name");return}
        guard let ship = singleton.getShip(by:shipName)  else {print("couldnt find ship");return}
        guard let destination = segue.destination as? ShipDetailViewController else {print("wrong dest");return}
        destination.ship = ship
    }
 

}

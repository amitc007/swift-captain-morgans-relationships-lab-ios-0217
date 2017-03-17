//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Edmund Holderbaum on 3/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class PiratesTableViewController: UITableViewController {

    let singleton = DataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        print("IN PiratesTableViewController:viewDidLoad")
        if singleton.getPiratesCount() == 0 {
            singleton.generateTestData()
        }
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return singleton.getPiratesCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pirateCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = singleton.getPirate(at: indexPath.row).name
        
        return cell
    }
    

       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let selectedRow = tableView.indexPathForSelectedRow?.row
        var destVC = segue.destination as! ShipsTableViewController
        destVC.pirate = singleton.getPirate(at: selectedRow!)
    }
    

}

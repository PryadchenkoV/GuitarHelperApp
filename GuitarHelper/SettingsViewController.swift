//
//  SettingsViewController.swift
//  GuitarHelper
//
//  Created by Ivan Pryadchenko on 03.08.16.
//  Copyright © 2016 Ivan Pryadchenko. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewSettings: UITableView!
    
    let settingsArray = ["Notification"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings.delegate = self
        tableViewSettings.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableSettings") as! SettingsTableViewCell
        cell.lableName.text = settingsArray[indexPath.row]
        return cell
    }

    

}

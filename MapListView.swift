//
//  MapListView.swift
//  Help
//
//  Created by Kaiqi Fan on 6/1/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import Foundation
import UIKit

class MapListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let memoryTag = UserDefaults.standard
    
    @IBOutlet weak var barcon: UINavigationItem!
    @IBOutlet weak var mapList: UITableView!
    
    
    let cityList = ["纽约", "华盛顿特区", "芝加哥", "波士顿", "旧金山", "费城", "亚特兰大", "洛杉矶"]
    let cityList2 = ["New York","Washington DC","Chicago","Boston","San Francisco","Philadelphia","Atlanta","Los Angeles"]
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapList.delegate = self
        mapList.dataSource = self
        
        if memoryTag.string(forKey: "flag") == "ON"{
            barcon.title = "地铁线路"
        }
        else{
            barcon.title = "Subway Maps"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The tableView has the same entry amount as the party amount
       // return introListContent.count
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // I'm using custom cell. Inside the cell there is a cell called partyList. The test will be displayed in this label for every party. The label is centered in the cell.
        
        let cell = self.mapList.dequeueReusableCell(withIdentifier: "MapListCell", for: indexPath) as! MapListCellModule
        if memoryTag.string(forKey: "flag") == "ON"{
            cell.mapLabel.text = cityList[indexPath.row]
        }
        else{
            cell.mapLabel.text = cityList2[indexPath.row]
        }
        cell.mapLabel.sizeToFit()
        cell.mapLabel.center.x = self.view.center.x
        
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if memoryTag.string(forKey: "flag") == "ON"{
            memoryTag.set(cityList[indexPath.row], forKey: "Map")
        }
        else{
            memoryTag.set(cityList2[indexPath.row], forKey: "Map")
        }
        self.performSegue(withIdentifier: "mapView", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Enable editing
        return true
    }
}

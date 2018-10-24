//
//  ExchangeViewController.swift
//  AECHelp2
//
//  Created by Kaiqi Fan on 6/23/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import Foundation

class ExchangeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var barcon: UINavigationItem!
    let memoryTag = UserDefaults.standard
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet weak var BackGround: UIImageView!
    @IBOutlet weak var exchangeList: UITableView!
    
    var ratioContent = [0.00, 1.00, -1.00, 0.00, 1.80, 1.00, 0.00, 1.00, 2.54, 30.48, 100.00, 100000.00, 161000.00, 0.00, 1.00, 28.35, 453.59, 1000.00, 0.00, 1.00, 29.57, 1000.00, 3785.41]
    var valueContent = [0.00, 0.00, 0.00, 0.00, 0.00, 32.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00]
    var labelContent = ["换汇（汇率每日更新）", "￥", "$", "温度单位", "ºC", "ºF","长度单位", "cm", "in", "ft", "m", "km", "mi", "重量单位", "g", "oz", "lb", "kg", "容量单位", "mL", "fl oz", "L", "gal"]
    var labelContent2 = ["Exchange Rate", "￥", "$", "Temperature Unit", "ºC", "ºF","Length Unit", "cm", "in", "ft", "m", "km", "mi", "Weight Unit", "g", "oz", "lb", "kg", "Capacity Unit", "mL", "fl oz", "L", "gal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeList.delegate = self
        exchangeList.dataSource = self
        
        let fullScreenSize = UIScreen.main.bounds.size
        
        BackGround.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height)
//        BackGround.image = UIImage(named: "Converter.png")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExchangeViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        if memoryTag.string(forKey: "flag") == "ON"{
            barcon.title = "单位转换"
        }
        else{
            barcon.title = "Unit Convert"
        }
        // USD Rate
        ratioContent[2] = parseJson(json: getJson())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard() -> Void {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The tableView has the same entry amount as the party amount
        return valueContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // I'm using custom cell. Inside the cell there is a cell called partyList. The test will be displayed in this label for every party. The label is centered in the cell.
        
        if ratioContent[indexPath.row] == 0 {
            let cell = self.exchangeList.dequeueReusableCell(withIdentifier: "ExchangeViewSubtitle", for: indexPath) as! ExchangeSubtitle
            if memoryTag.string(forKey: "flag") == "ON"{
                cell.subtitleLabel.text = labelContent[indexPath.row]
            }
            else{
                cell.subtitleLabel.text = labelContent2[indexPath.row]

            }
            cell.subtitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell.subtitleLabel.sizeToFit()
            cell.subtitleLabel.center.x = self.view.center.x
            return cell
        }
        
        let cell = self.exchangeList.dequeueReusableCell(withIdentifier: "ExchangeViewCell", for: indexPath) as! ExchangeCell
        
        cell.exchangeLabel.text = labelContent[indexPath.row]
        
        if cell.exchangeValue != nil {
            cell.exchangeValue.text = String(format: "%.2f", valueContent[indexPath.row])
        }
        
        cell.onStartEditing = {
            cell.exchangeValue.text = ""
            self.update(skipRow: indexPath.row)
        }
        
        cell.onValueModified = {
            var cache = cell.exchangeValue.text!
            if cache.range(of: "-") != nil {
                cache = cache.substring(to: (cache.range(of: "-")?.lowerBound)!) + cache.substring(from: (cache.range(of: "-")?.upperBound)!)
                cache = "-" + cache
                cell.exchangeValue.text = cache
            }
            
            switch cache {
            case ".":
                cache = "0."
                cell.exchangeValue.text = "0."
            case "-.":
                cache = "-0."
                cell.exchangeValue.text = "-0."
            case "-":
                cache = "-0"
                cell.exchangeValue.text = "-"
            case "":
                cache = "0"
                cell.exchangeValue.text = ""
            default:
                break
            }
            
            
            if cache.characters.count > 1 {
                if cache[cache.startIndex] == "0" && cache[cache.index(after: cache.startIndex)] != "." {
                    let index = cache.index(cache.startIndex, offsetBy: 1)
                    cache = cache.substring(from: index)
                    cell.exchangeValue.text = cache
                }
            }
            
            if cache.characters.count > 2 {
                if cache[cache.startIndex] == "-" && cache[cache.index(after: cache.startIndex)] == "0" && cache[cache.index(cache.startIndex, offsetBy: 2)] != "." {
                    let index = cache.index(cache.startIndex, offsetBy: 2)
                    cache = cache.substring(from: index)
                    cache = "-" + cache
                    cell.exchangeValue.text = cache
                }
            }
            
            var value = Double(cache)!
            
            self.valueContent[indexPath.row] = value
            
            var range = 0...0  // Default
            if indexPath.row < 3 {
                range = 1...2
            } else if indexPath.row < 6 {
                range = 4...5
            } else if indexPath.row < 13 {
                range = 7...12
            } else if indexPath.row < 18 {
                range = 14...17
            } else if indexPath.row < 23 {
                range = 19...22
            }
            
            for i in range {
                if self.ratioContent[i] != 0.0 && i != indexPath.row {
                    // Farenheit to Celcius
                    if i == 4 {
                        value -= 32.00;
                    }
                    self.valueContent[i] = value * self.ratioContent[indexPath.row] / self.ratioContent[i]
                    // Celcius to Farenheit
                    if i == 5 {
                        self.valueContent[i] += 32.00
                    }
                }
            }
            
            self.update(skipRow: indexPath.row)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Enable editing
        return true
    }
    
    func update(skipRow: Int) -> Void {
        var range = 0...0 // Default
        if skipRow < 3 {
            range = 1...2
            if (ratioContent[2] == -1.00) {
                let alertController = UIAlertController(title: "失败", message: "汇率获取异常", preferredStyle: .alert)
                let actionconf = UIAlertAction(title:"确定", style:.default){ (action:UIAlertAction) in
                }
                alertController.addAction(actionconf)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        } else if skipRow < 6 {
            range = 4...5
        } else if skipRow < 13 {
            range = 7...12
        } else if skipRow < 18 {
            range = 14...17
        } else if skipRow < 23 {
            range = 19...22
        }
        
        var indexPath = Array<IndexPath> ()
        for i in range {
            if i != skipRow {
                indexPath.append(IndexPath(row: i, section: 0))
            }
        }
        
        self.exchangeList.beginUpdates()
        self.exchangeList.reloadRows(at: indexPath, with: .fade)
        self.exchangeList.endUpdates()
    }
    
    func getJson() -> String {
        
        guard let myURL = URL(string: "http://api.fixer.io/latest?base=USD&symbols=CNY") else {
            return "Error!"
        }
        
        do {return try String(contentsOf: myURL, encoding: .utf8)} catch {return "Error Connection!"}
    }
    
    func parseJson(json: String) -> Double {
        do {
            if let data = json.data(using: .utf8, allowLossyConversion: true),
                let json0 = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any],
                let trans_result = json0["rates"] as? [String: Any] {
                //print(trans_result)
                if let output = trans_result["CNY"] as? Double {
                    //print(output)
                    return output
                }
            }
            
            return -1.00
        }
        catch {
            return -1.00
        }
    }
}

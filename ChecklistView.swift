//
//  ChecklistView.swift
//  AECHelp2
//
//  Created by Kaiqi Fan on 6/23/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import Foundation

class ChecklistView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    let memoryTag = UserDefaults.standard
    
    @IBOutlet weak var barcon: UINavigationItem!
    var checklistContent: [String] =
        ["ISA复印件", "毕业证学位证原件", "I20表原件", "体检表原件", "现金和信用卡",
         "双频手机", "双语美国地图", "咖啡（调时差用）", "方便面（应急食品，不带肉最好）", "紧急联系人地址",
         "联系家长专用邮箱", "简易药品", "闹钟", "笔记本电脑", "美标转换插头",
         "充电器", "U盘/移动硬盘", "音像制品", "中文教科书", "字典和语法书",
         "洗漱用品", "床单和毛巾", "家人照片", "眼镜（美国很贵）", "冬装（冬天来的快）",
         "传统服饰（唐装旗袍）", "其他你想带的"]
    var checklistContent2: [String] = ["Credit Card","Cash","Phone Charger","Laptop"]
    
    let statInfo = UserDefaults.standard

    @IBOutlet weak var checklist: UITableView!
    @IBOutlet weak var BackGround: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if memoryTag.string(forKey: "flag") == "ON"{
            barcon.title = "行李清单"
        }
        else{
            barcon.title = "Luggage List"
        }

    }
    

    override func viewWillAppear(_ animated: Bool) {
        
//        let fullScreenSize = UIScreen.main.bounds.size
        checklist.delegate = self
        checklist.dataSource = self
        
//        BackGround.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height)
//        BackGround.image = UIImage(named:"Luggage.png")
        
        if memoryTag.string(forKey: "flag") == "ON"{
            checklistContent = getPartyList()
        }
        else{
            checklistContent2 = getPartyList()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The tableView has the same entry amount as the party amount
        if memoryTag.string(forKey: "flag") == "ON"{
            return checklistContent.count
        }
        else{
            return checklistContent2.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // I'm using custom cell. Inside the cell there is a cell called partyList. The test will be displayed in this label for every party. The label is centered in the cell.
        
        let cell = self.checklist.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath) as! ChecklistCell
        if self.memoryTag.string(forKey: "flag") == "ON"{
            cell.checklistLabel.text = checklistContent[indexPath.row]
        }
        else{
            cell.checklistLabel.text = checklistContent2[indexPath.row]
        }
        cell.checklistLabel.sizeToFit()
        
        if getStat(position: indexPath.row) {cell.accessoryType = .checkmark}
        else {cell.accessoryType = .none}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Enable editing
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateStat(position: indexPath.row)
        checklist.beginUpdates()
        checklist.reloadRows(at: [indexPath], with: .fade)
        checklist.endUpdates()
    }
    
    func getStat(position: Int) -> Bool {
        let stat = statInfo.bool(forKey: "stat\(position)")
        return stat
    }
    
    func updateStat(position: Int) -> Void {
        statInfo.set(!statInfo.bool(forKey: "stat\(position)"), forKey: "stat\(position)")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            if self.memoryTag.string(forKey: "flag") == "ON"{
                deleteParty(partyID: checklistContent[indexPath.row])
                checklistContent.remove(at: indexPath.row)
                tableView.reloadData()
            }
            else{
                deleteParty(partyID: checklistContent2[indexPath.row])
                checklistContent2.remove(at: indexPath.row)
                tableView.reloadData()

            }
        }
    }
    
    @IBAction func moreInfo(_ sender: UIBarButtonItem) {
        var fieldcontent = ""
        
        if self.memoryTag.string(forKey: "flag") == "ON"{
        let alert = UIAlertController(title: "添加新行", message:  "请输入内容", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = ""
        }

            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            fieldcontent = (textField?.text)!
                self.checklistContent.append(fieldcontent)
                self.checklist.beginUpdates()
                self.checklist.insertRows(at: [IndexPath(row: self.checklistContent.count-1, section: 0)], with: .automatic)
                self.checklist.endUpdates()
                self.AddParty(partyID: fieldcontent)
            }))
            alert.addAction(UIAlertAction(title:"取消", style: .default, handler: { [] (_) in}))
            self.present(alert, animated: true, completion: nil)
        }
        else{
                let alert = UIAlertController(title: "Add A New Item", message:  "Please Input", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.text = ""
                }
            
                alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                    fieldcontent = (textField?.text)!
                    self.checklistContent2.append(fieldcontent)
                    self.checklist.beginUpdates()
                    self.checklist.insertRows(at: [IndexPath(row: self.checklistContent2.count-1, section: 0)], with: .automatic)
                    self.checklist.endUpdates()
                    self.AddParty(partyID: fieldcontent)
                }))
                alert.addAction(UIAlertAction(title:"Cancel", style: .default, handler: { [] (_) in}))
                self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func deleteParty(partyID: String){
        let oldPartyList = getPartyList()
        var flag = false
        var updatedPartyList = Array<String>()
        
        let range = 0 ... oldPartyList.count - 1
        for i in range{
            if oldPartyList[i] != partyID{
                updatedPartyList.append(oldPartyList[i])
            }
            if oldPartyList[i] == partyID{
                flag = true
            }
            if flag == true{
                if i < oldPartyList.count - 1{
                    statInfo.set(getStat(position: i+1), forKey: "stat\(i)")
                }
                if i == oldPartyList.count - 1{
                    statInfo.set(false, forKey: "stat\(i)")
                }
            }
        }
        let partyData = NSKeyedArchiver.archivedData(withRootObject: updatedPartyList)
        if memoryTag.string(forKey: "flag") == "ON"{
            statInfo.set(partyData, forKey:"partyList")
        }
        else{
            statInfo.set(partyData, forKey:"partyList2")
        }
        
    }
    
    func getPartyList() -> Array<String> {
        var data = statInfo.object(forKey: "partyList") as? Data
        if memoryTag.string(forKey: "flag") != "ON"{
            data = statInfo.object(forKey: "partyList2") as? Data
        }
        var partyList : Array<String>
        if let data = data{
            partyList = NSKeyedUnarchiver.unarchiveObject(with: data) as! Array<String>
        }
        else{
            if memoryTag.string(forKey: "flag") == "ON"{
                partyList = ["ISA复印件", "毕业证学位证原件", "I20表原件", "体检表原件", "现金和信用卡",
                         "双频手机", "双语美国地图", "咖啡（调时差用）", "方便面（应急食品，不带肉最好）", "紧急联系人地址",
                         "联系家长专用邮箱", "简易药品", "闹钟", "笔记本电脑", "美标转换插头",
                         "充电器", "U盘/移动硬盘", "音像制品", "中午教科书", "字典和语法书",
                         "洗漱用品", "床单和毛巾", "家人照片", "眼镜（美国很贵）", "冬装（冬天来的快）",
                         "传统服饰（唐装旗袍）", "其他你想带的"]
            }
            else{
               partyList = ["Credit Card","Cash","Phone Charger","Laptop"]

            }
        }
        return partyList
    }
    
    func AddParty(partyID: String){
        var oldPartyList = getPartyList()
        
        oldPartyList.append(partyID)
        
        let partyData = NSKeyedArchiver.archivedData(withRootObject: oldPartyList)
        if memoryTag.string(forKey: "flag") == "ON"{
            statInfo.set(partyData, forKey:"partyList")
        }
        else{
            statInfo.set(partyData, forKey:"partyList2")
        }
    }

}

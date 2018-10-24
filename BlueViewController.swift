//
//  BlueViewController.swift
//  DolphinAssistant
//
//  Created by Kaiqi Fan on 8/11/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    let fullScreenSize = UIScreen.main.bounds.size
    let memoryTag = UserDefaults.standard
    
    @IBOutlet weak var map: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var content1: UIButton!
    @IBOutlet weak var content2: UIButton!
    @IBOutlet weak var content3: UIButton!
    @IBOutlet weak var content4: UIButton!
    @IBOutlet weak var content5: UIButton!
    @IBOutlet weak var content6: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if memoryTag.string(forKey: "flag") == "ON"{
            content1.setTitle("华盛顿", for: .normal)
            content2.setTitle("纽约", for: .normal)
            content3.setTitle("芝加哥", for: .normal)
            content4.setTitle("旧金山", for: .normal)
            content5.setTitle("洛杉矶", for: .normal)
            content6.setTitle("休斯顿", for: .normal)
        }
        else{
            content1.setTitle("Washington DC", for: .normal)
            content2.setTitle("New York", for: .normal)
            content3.setTitle("Chicago", for: .normal)
            content4.setTitle("San Francisco", for: .normal)
            content5.setTitle("Los Angeles", for: .normal)
            content6.setTitle("Houston", for: .normal)
        }
        
        background.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height)
        background.image = UIImage(named: "Action2.png")
        self.view.addSubview(background)
        
        map.frame = CGRect(x: 0, y: fullScreenSize.height / 8, width: 1000 / 3, height: 2 * 359 / 3)
        map.image = UIImage(named:"CBMap.gif")
        map.contentMode = .scaleToFill
        map.center.x = fullScreenSize.width / 2
        self.view.addSubview(map)
        
        content1.frame = CGRect(x: fullScreenSize.width/5, y: 6 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        content1.sizeToFit()
        content1.titleLabel?.textAlignment = .center
        content1.center.x = fullScreenSize.width / 5
        content1.addTarget(self, action: #selector(move1),for: .touchUpInside)
        self.view.addSubview(content1)
        
        content2.frame = CGRect(x: fullScreenSize.width/5, y: 6 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        content2.sizeToFit()
        content2.titleLabel?.textAlignment = .center
        content2.center.x = fullScreenSize.width / 2
        content2.addTarget(self, action: #selector(move2),for: .touchUpInside)
        self.view.addSubview(content2)
        
        content3.frame = CGRect(x: fullScreenSize.width/5, y: 6 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        content3.sizeToFit()
        content3.titleLabel?.textAlignment = .center
        content3.center.x = 4 * fullScreenSize.width / 5
        content3.addTarget(self, action: #selector(move3),for: .touchUpInside)
        self.view.addSubview(content3)
        
        content4.frame = CGRect(x: fullScreenSize.width/5, y: 7 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        content4.sizeToFit()
        content4.titleLabel?.textAlignment = .center
        content4.center.x = fullScreenSize.width / 5
        content4.addTarget(self, action: #selector(move4),for: .touchUpInside)
        self.view.addSubview(content4)
        
        content5.frame = CGRect(x: fullScreenSize.width/5, y: 7 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        content5.sizeToFit()
        content5.titleLabel?.textAlignment = .center
        content5.center.x = fullScreenSize.width / 2
        content5.addTarget(self, action: #selector(move5),for: .touchUpInside)
        self.view.addSubview(content5)
        
        content6.frame = CGRect(x: fullScreenSize.width/5, y: 7 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        content6.sizeToFit()
        content6.titleLabel?.textAlignment = .center
        content6.center.x = 4 * fullScreenSize.width / 5
        content6.addTarget(self, action: #selector(move6),for: .touchUpInside)
        self.view.addSubview(content6)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    func move1(sender: UIButton!){
        self.performSegue(withIdentifier: "move1", sender: self)
    }
    
    func move2(sender: UIButton!){
        self.performSegue(withIdentifier: "move2", sender: self)
    }
    
    func move3(sender: UIButton!){
        self.performSegue(withIdentifier: "move3", sender: self)
    }
    
    func move4(sender: UIButton!){
        self.performSegue(withIdentifier: "move4", sender: self)
    }
    
    func move5(sender: UIButton!){
        self.performSegue(withIdentifier: "move5", sender: self)
    }
    
    func move6(sender: UIButton!){
        self.performSegue(withIdentifier: "move6", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

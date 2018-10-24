//
//  GreenViewController.swift
//  DolphinAssistant
//
//  Created by Kaiqi Fan on 8/10/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import CoreTelephony

class GreenViewController: UIViewController {
    
    let fullScreenSize = UIScreen.main.bounds.size
    let memoryTag = UserDefaults.standard
    
    let callWebView = UIWebView()
    
    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Title2: UILabel!
    @IBOutlet weak var Phone1: UIButton!
    @IBOutlet weak var Phone2: UIButton!
    @IBOutlet weak var Title3: UILabel!
    @IBOutlet weak var Phone3: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if memoryTag.string(forKey: "flag") == "ON"{
            Title1.text = "美国与加拿大报警电话"
            Title2.text = "英国及英联邦报警电话"
            Title3.text = "国际通用报警电话"
        }
        else{
            Title1.text = "US&Canada\nEmergency Number"
            Title2.text = "UK&British Commonwealth"
            Title3.text = "International Common\nEmergency Number"
        }
        
        background.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height)
        background.image = UIImage(named: "Action1.png")
        self.view.addSubview(background)
        
        Title1.frame = CGRect(x: fullScreenSize.width/5, y: 2 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        Title1.numberOfLines = 2
        Title1.sizeToFit()
        Title1.textAlignment = .center
        Title1.center.x = fullScreenSize.width / 2
        self.view.addSubview(Title1)
        
        Phone1.sizeToFit()
        Phone1.center.y = 3 * fullScreenSize.height / 9
        Phone1.center.x = fullScreenSize.width / 2
        self.view.addSubview(Phone1)
        
        Title2.frame = CGRect(x: fullScreenSize.width/5, y: 4 * fullScreenSize.height / 9, width: fullScreenSize.width * 4 / 5, height: fullScreenSize.width/4)
        Title2.numberOfLines = 2
        Title2.sizeToFit()
        Title2.textAlignment = .center
        Title2.center.x = fullScreenSize.width / 2
        self.view.addSubview(Title2)
        
        Phone2.sizeToFit()
        Phone2.center.y = 5 * fullScreenSize.height / 9
        Phone2.center.x = fullScreenSize.width / 2
        self.view.addSubview(Phone2)
        
        Title3.frame = CGRect(x: fullScreenSize.width/5, y: 6 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        Title3.numberOfLines = 2
        Title3.sizeToFit()
        Title3.textAlignment = .center
        Title3.center.x = fullScreenSize.width / 2
        self.view.addSubview(Title3)
        
        Phone3.sizeToFit()
        Phone3.center.y = 7 * fullScreenSize.height / 9
        Phone3.center.x = fullScreenSize.width / 2
        self.view.addSubview(Phone3)

        
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

    @IBAction func USCall(_ sender: Any) {
        let number = "911"
        callWebView.loadRequest(URLRequest(url:URL(string: "tel:\(number)")!))
        UIApplication.shared.open(URL(string:number)!, options: ["":""], completionHandler: nil)
    }
    
    
    @IBAction func UKCall(_ sender: Any) {
        let number = "999"
        callWebView.loadRequest(URLRequest(url:URL(string: "tel:\(number)")!))
        UIApplication.shared.open(URL(string:number)!, options: ["":""], completionHandler: nil)
    }
    
    
    @IBAction func CommonCall(_ sender: Any) {
        let number = "112"
        callWebView.loadRequest(URLRequest(url:URL(string: "tel:\(number)")!))
        UIApplication.shared.open(URL(string:number)!, options: ["":""], completionHandler: nil)

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

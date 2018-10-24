//
//  ViewController.swift
//  DolphinAssistant
//
//  Created by Kaiqi Fan on 8/3/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let fullScreenSize = UIScreen.main.bounds.size
    let memoryTag = UserDefaults.standard
    
    @IBOutlet weak var changeLG: UIBarButtonItem?
    @IBOutlet weak var barcon: UINavigationItem!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var Tips: UIButton!
    @IBOutlet weak var Transform: UIButton!
    @IBOutlet weak var Checklist: UIButton!
    @IBOutlet weak var Translate: UIButton!
    @IBOutlet weak var Map: UIButton!
    var flag = "ON"
    let imageCH = UIImage(named: "CH.png") as UIImage?
    let imageEN = UIImage(named: "EN.png") as UIImage?
    var image = UIImage(named: "Subway.png") as UIImage?
    var image2 = UIImage(named: "Converter.png") as UIImage?
    var image3 = UIImage(named: "Tips.png") as UIImage?
    var image4 = UIImage(named: "Translation.png") as UIImage?
    var image5 = UIImage(named: "Checklist.png") as UIImage?
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Map.addTarget(self, action: #selector(ViewController.Map(_:)), for: .touchUpInside)
        Translate.addTarget(self, action: #selector(ViewController.Translate(_:)), for: .touchUpInside)
        Checklist.addTarget(self, action: #selector(ViewController.Checklist(_:)), for: .touchUpInside)
        Transform.addTarget(self, action: #selector(ViewController.Transform(_:)), for: .touchUpInside)
        Tips.addTarget(self, action: #selector(ViewController.Tips(_:)), for: .touchUpInside)

    }

    override func viewWillAppear(_ animated: Bool) {
        
        if memoryTag.string(forKey: "flag") == "ON"{
            changeLG?.title = "EN"
            barcon.title = "海豚留学助手"
            barcon.backBarButtonItem?.title = "主页"
            image = UIImage(named: "Subway.png") as UIImage?
            image2 = UIImage(named: "Converter.png") as UIImage?
            image3 = UIImage(named: "Tips.png") as UIImage?
            image4 = UIImage(named: "Translation.png") as UIImage?
            image5 = UIImage(named: "Checklist.png") as UIImage?
        }
        else{
//            changeLG?.image = imageCH
            changeLG?.title = "中"
            barcon.title = "Dolphin Assistant"
            barcon.backBarButtonItem?.title = "Main Page"
            image = UIImage(named: "EN-SubwayMaps.png") as UIImage?
            image2 = UIImage(named: "EN-UnitConverter.png") as UIImage?
            image3 = UIImage(named: "EN-TipsCalculator.png") as UIImage?
            image4 = UIImage(named: "CN-ENTranslation.png") as UIImage?
            image5 = UIImage(named: "EN-LuggageList.png") as UIImage?
        }
        
        background.frame = CGRect(x: 0, y: 20, width: fullScreenSize.width, height: fullScreenSize.height)
        background.image = UIImage(named: "MainPageBG.png")
        background.contentMode =  .scaleToFill
        self.view.addSubview(background)
        
        
        Map.frame = CGRect(x: fullScreenSize.width/10, y: fullScreenSize.height/8, width: fullScreenSize.width/4, height: fullScreenSize.width/4)
        Map.setBackgroundImage(image, for: .normal)
        self.view.addSubview(Map)
        
        
        Transform.frame = CGRect(x: 2 * fullScreenSize.width/10, y: 3 * fullScreenSize.height/9, width: fullScreenSize.width/5, height: fullScreenSize.width/5)
        Transform.setBackgroundImage(image2, for: .normal)
        self.view.addSubview(Transform)
        
        
        Tips.frame = CGRect(x: 7 * fullScreenSize.width/11, y: fullScreenSize.height/3, width: fullScreenSize.width/4, height: fullScreenSize.width/4)
        Tips.setBackgroundImage(image3, for: .normal)
        self.view.addSubview(Tips)
        
      
        Translate.frame = CGRect(x: 7 * fullScreenSize.width/10, y: fullScreenSize.height/7, width: fullScreenSize.width/5, height: fullScreenSize.width/5)
        Translate.setBackgroundImage(image4, for: .normal)
        self.view.addSubview(Translate)
        
        
        Checklist.frame = CGRect(x: 4 * fullScreenSize.width/10 , y: fullScreenSize.height/4 - fullScreenSize.height/40, width: fullScreenSize.width/5 , height: fullScreenSize.width/5 )
        Tips.setBackgroundImage(image3, for: .normal)
        Checklist.setBackgroundImage(image5, for: .normal)
        self.view.addSubview(Checklist)
        
        
    }
    
    @IBAction func changeLG(_ sender: Any) {
        if self.flag == "ON"{
            flag = "OFF"
            self.memoryTag.set("OFF",forKey:"flag")
            DispatchQueue.main.async (execute: {
                let alertController = UIAlertController(title: "Tips:", message:"The Language has been changed!", preferredStyle: .alert)
                let actionconf = UIAlertAction(title:"Confirm", style:.default){ (action:UIAlertAction) in
                    
                    self.viewWillAppear(true)
                }
                alertController.addAction(actionconf)
                self.present(alertController, animated: true, completion: nil)
            })
        }
        else{
            flag = "ON"
            self.memoryTag.set("ON",forKey:"flag")
            DispatchQueue.main.async (execute: {
                let alertController = UIAlertController(title: "提示", message:"语言已切换！", preferredStyle: .alert)
                let actionconf = UIAlertAction(title:"确定", style:.default){ (action:UIAlertAction) in
                    
                    self.viewWillAppear(true)
                }
                alertController.addAction(actionconf)
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func Map(_ sender: UIButton){
        self.performSegue(withIdentifier: "Map", sender: self)
    }

    func Translate(_ sender: UIButton){
        self.performSegue(withIdentifier: "Translate", sender: self)
    }
    
    func Checklist(_ sender: UIButton){
        self.performSegue(withIdentifier: "Checklist", sender: self)
    }
    
    func Transform(_ sender: UIButton){
        self.performSegue(withIdentifier: "Transform", sender: self)
    }
    
    func Tips(_ sender: UIButton){
        self.performSegue(withIdentifier: "Tips", sender: self)
    }
}


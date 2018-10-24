//
//  FirstViewController.swift
//  DolphinAssistant
//
//  Created by Kaiqi Fan on 8/3/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController{

    let fullScreenSize = UIScreen.main.bounds.size
    let memoryTag = UserDefaults.standard
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var water: UIImageView!
    @IBOutlet weak var whale: UIButton!
    @IBOutlet weak var Ball: UIImageView!
    @IBOutlet weak var brand: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        background.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height)
        background.image = UIImage(named: "Background1.png")
        background.contentMode =  .scaleToFill
        self.view.addSubview(background)
        
        brand.frame = CGRect(x: 20, y: fullScreenSize.height / 3, width: 3 * fullScreenSize.width/6, height: fullScreenSize.height / 12)
        brand.image = UIImage(named: "Wording.png")
        brand.contentMode =  .scaleToFill
        self.view.addSubview(brand)
        
        whale.frame = CGRect(x: fullScreenSize.width / 6, y: 11 * fullScreenSize.height/18, width: 2 * fullScreenSize.height/9, height: 3 * fullScreenSize.height/9)
        whale.contentMode = .scaleToFill
        self.view.addSubview(whale)
        
        water.frame = CGRect(x: 0, y: 6 * fullScreenSize.height/9, width: fullScreenSize.width, height: 3 * fullScreenSize.height/9)
        water.image = UIImage(named: "Sea.png")
        water.contentMode = .scaleToFill
        self.view.addSubview(water)
        
        Ball.frame = CGRect(x: 2 * fullScreenSize.width / 6 + 2 * fullScreenSize.height/9, y: 9 * fullScreenSize.height/18-50, width: fullScreenSize.height/9, height: fullScreenSize.height/9)
        Ball.image = UIImage(named: "Ball.png")
        Ball.contentMode = .scaleToFill
        self.view.addSubview(Ball)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.push(_:)))
        self.view.addGestureRecognizer(tap)
        
        whale.addTarget(self, action: #selector(FirstViewController.push(_:)), for: .touchUpInside)
        
        
        
        
    }

    func push(_ sender: UIButton){
        self.memoryTag.set("ON",forKey:"flag")
        UIView.beginAnimations(nil, context: nil)
        
        self.whale.frame = CGRect(x: 2 * fullScreenSize.width / 6, y: 9 * fullScreenSize.height/18, width: 2 * fullScreenSize.height/9, height: 3 * fullScreenSize.height/9)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeOut)
        UIView.setAnimationDuration(100.0)
        UIView.commitAnimations()
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            self.performSegue(withIdentifier: "Push", sender: self)
        }

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

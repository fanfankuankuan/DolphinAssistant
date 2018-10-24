//
//  TranslateView.swift
//  AECHelp2
//
//  Created by Kaiqi Fan on 6/23/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import Foundation


class TranslateView: UIViewController {

    let urlBase = "http://api.fanyi.baidu.com/api/trans/vip/translate"
    
    var from = "from="
    var to = "to="
    let appid = "20170612000057737"
    var salt = "\(Int(arc4random_uniform(UInt32(99999999))))"
    let password = "FnepDY9YzfzuSwWwdw_1"
    
    let memoryTag = UserDefaults.standard

    @IBOutlet weak var barcon: UINavigationItem!
    @IBOutlet weak var inputtext: UITextField!
    @IBOutlet weak var BackGround: UIImageView!
    @IBOutlet weak var outputText: UITextView!
    @IBOutlet weak var inputText: UITextView!
    @IBOutlet weak var ENTOCH: UIButton!
    @IBOutlet weak var CHTOEN: UIButton!
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TranslateView.hideKeyboard))
        view.addGestureRecognizer(tap)
        
        if memoryTag.string(forKey: "flag") == "ON"{
            barcon.title = "中英翻译"
            inputtext.text = "请在下方输入"
            ENTOCH.setTitle("英译中",for: .normal)
            ENTOCH.sizeToFit()
            CHTOEN.setTitle("中译英",for: .normal)
            CHTOEN.sizeToFit()
        }
        else{
            barcon.title = "Translation"
            inputtext.text = "Input Here"
            ENTOCH.setTitle("EN to CN",for: .normal)
            ENTOCH.sizeToFit()
            CHTOEN.setTitle("CN to EN",for: .normal)
            CHTOEN.sizeToFit()
        }
        ENTOCH.center.x = self.view.center.x / 2
        CHTOEN.center.x = self.view.center.x / 2 * 3
//        let fullScreenSize = UIScreen.main.bounds.size
        
//        BackGround.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height)
//        BackGround.image = UIImage(named: "Translation.png")
        
        inputText.layer.borderColor = UIColor.gray.cgColor
        inputText.layer.borderWidth = 0.5
        inputText.layer.cornerRadius = 5.0
        inputtext.sizeToFit()
        
        inputText.autocapitalizationType = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func translateNow(_ sender: UIButton) {
        if inputText.text.isEmpty {return}
        outputText.text = parseHTML(html: htmlScript(method: sender.tag, text: inputText.text)).replacingOccurrences(of: "||", with: "\n").replacingOccurrences(of: "| |", with: "\n")
        hideKeyboard()
    }
    
    func hideKeyboard() -> Void {
        inputText.endEditing(true)
    }
    
    func htmlScript(method: Int, text: String) -> String {
        let input = text.replacingOccurrences(of: "\n", with: " ||")
        let urlChunk = (appid + input + salt + password).md5()
        if method == 1 {from = "from=en"; to = "to=zh"} else {from = "from=zh"; to = "to=en"}
        let myURLString = urlBase + "?q=" + input.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! + "&" + from + "&" + to + "&appid=" + appid + "&salt=" + salt + "&sign=" + urlChunk
        
        guard let myURL = URL(string: myURLString) else {
            return myURLString
        }
        
        do {return try String(contentsOf: myURL, encoding: .utf8)} catch {return "Error Connection!"}
    }
    
    func parseHTML(html: String) -> String {
        do {
            if let data = html.data(using: .utf8, allowLossyConversion: true),
                let json0 = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any],
                let trans_result = json0["trans_result"] as? [[String: Any]] {
                for result in trans_result {
                    if let output = result["dst"] as? String {
                        return output.replacingOccurrences(of: "#", with: "\n")
                    }
                }
            }
            
            return "Error!!!"
        }
        catch {
            return "Error!!!"
        }
        
    }

}

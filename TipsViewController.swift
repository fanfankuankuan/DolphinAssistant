//
//  TipsViewController.swift
//  AECHelp2
//
//  Created by Kaiqi Fan on 7/24/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController,UITextFieldDelegate {

    let memoryTag = UserDefaults.standard
    
    @IBOutlet weak var barcon: UINavigationItem!
    
    @IBOutlet var Viewpart: UIView!
    @IBOutlet weak var Tiptitle: UILabel!
    @IBOutlet weak var Money: UITextField!
    
    @IBOutlet weak var People: UILabel!
    @IBOutlet weak var PeoNum: UITextField!
    
    @IBOutlet weak var Summary: UILabel!
    @IBOutlet weak var Tipvalue: UILabel!
    @IBOutlet weak var Tiprate: UILabel!
    
    @IBOutlet weak var tenrate: UILabel!
    @IBOutlet weak var tenval: UILabel!
    @IBOutlet weak var tentotal: UILabel!
    
    @IBOutlet weak var fifthrate: UILabel!
    @IBOutlet weak var fifthval: UILabel!
    @IBOutlet weak var fifthtotal: UILabel!
    
    @IBOutlet weak var eightrate: UILabel!
    @IBOutlet weak var eightval: UILabel!
    @IBOutlet weak var eighttotal: UILabel!
    
    @IBOutlet weak var twenrate: UILabel!
    @IBOutlet weak var twenval: UILabel!
    @IBOutlet weak var twentotal: UILabel!
    
    @IBOutlet weak var otherrate: UITextField!
    @IBOutlet weak var otherval: UITextField!
    @IBOutlet weak var othertotal: UILabel!

    @IBOutlet weak var ratesymbol: UILabel!
    
    var res: String! = ""
    var res2: String! = ""
    var res3: String! = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if memoryTag.string(forKey: "flag") == "ON"{
            barcon.title = "小费计算器"
        }
        else{
            barcon.title = "Tips Calculator"
        }
       
        // Do any additional setup after loading the view.
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mainSize = UIScreen.main.bounds.size
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TipsViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
        Tiptitle.frame = CGRect(x: mainSize.width / 3, y: mainSize.height / 8, width: mainSize.width/3, height: 30)
        if memoryTag.string(forKey: "flag") == "ON"{
            Tiptitle.text = "总金额"
        }
        else{
            Tiptitle.text = "Total Amount"
        }
        Tiptitle.textColor = UIColor.red
        Tiptitle.textAlignment = .center
        Tiptitle.font = UIFont.systemFont(ofSize: 20)
        Tiptitle.sizeToFit()
        Tiptitle.center.x = self.view.center.x / 2
        Viewpart.addSubview(Tiptitle)
        
       
        Money.frame = CGRect(x:mainSize.width/4, y:mainSize.height / 7 + 30, width: mainSize.width/4, height:30)
        Money.keyboardType = .numbersAndPunctuation
        Money.adjustsFontSizeToFitWidth = true
        Money.center.x = self.view.center.x / 2
        Money.text = "0"
        Money.delegate = self
        Viewpart.addSubview(Money)
        
        
        People.frame = CGRect(x: mainSize.width / 3, y: mainSize.height / 8, width: mainSize.width/3, height: 30)
        if memoryTag.string(forKey: "flag") == "ON"{
            People.text = "总人数"
        }
        else{
            People.text = "Total People"
        }
        People.textColor = UIColor.red
        People.textAlignment = .center
        People.font = UIFont.systemFont(ofSize: 20)
        People.sizeToFit()
        People.center.x = 3 * self.view.center.x / 2
        Viewpart.addSubview(People)
        
        
        PeoNum.frame = CGRect(x:mainSize.width/4, y:mainSize.height / 7 + 30, width: mainSize.width/4, height:30)
        PeoNum.keyboardType = .numberPad
        PeoNum.adjustsFontSizeToFitWidth = true
        PeoNum.center.x = 3 * self.view.center.x / 2
        PeoNum.textAlignment = .center
        PeoNum.text = "1"
        PeoNum.delegate = self
        Viewpart.addSubview(PeoNum)
        
        
        Tiprate.frame = CGRect(x: mainSize.width / 6, y: mainSize.height / 7 + 15 + mainSize.height/9, width: 143, height: 30)
        if memoryTag.string(forKey: "flag") == "ON"{
            Tiprate.text = "小费比率"
        }
        else{
            Tiprate.text = "Tips Rate"
        }
        Tiprate.textColor = UIColor.purple
        Tiprate.font = UIFont.boldSystemFont(ofSize: 20.0)
        Tiprate.textAlignment = .center
        Tiprate.sizeToFit()
        Tiprate.center.x = self.view.center.x / 3
        Viewpart.addSubview(Tiprate)
        
        Tipvalue.frame = CGRect(x: mainSize.width / 3, y: mainSize.height / 7 + 15 + mainSize.height/9, width: mainSize.width/6, height: 30)
        if memoryTag.string(forKey: "flag") == "ON"{
            Tipvalue.text = "小费金额"
        }
        else{
            Tipvalue.text = "Tips Value"
        }
        Tipvalue.textColor = UIColor.purple
        Tipvalue.font = UIFont.boldSystemFont(ofSize: 20.0)
        Tipvalue.textAlignment = .center
        Tipvalue.sizeToFit()
        Tipvalue.center.x = self.view.center.x
        Viewpart.addSubview(Tipvalue)
        
        Summary.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 15 + mainSize.height/9, width: mainSize.width/6, height: 30)
        if memoryTag.string(forKey: "flag") == "ON"{
            Summary.text = "最终金额"
        }
        else{
            Summary.text = "Grand Total"
        }
        Summary.textColor = UIColor.purple
        Summary.font = UIFont.boldSystemFont(ofSize: 20.0)
        Summary.textAlignment = .center
        Summary.sizeToFit()
        Summary.center.x = 5 * self.view.center.x / 3
        Viewpart.addSubview(Summary)

        tenrate.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 2 * mainSize.height/9, width: mainSize.width/6, height: 30)
        tenrate.text = "10%"
        tenrate.textColor = UIColor.black
        tenrate.textAlignment = .center
//        tenrate.sizeToFit()
        tenrate.center.x = self.view.center.x / 3
        Viewpart.addSubview(tenrate)
        
        tenval.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 2 * mainSize.height/9, width: mainSize.width/6, height: 30)
        tenval.text = "0"
        tenval.textColor = UIColor.red
        tenval.textAlignment = .center
//        tenval.sizeToFit()
        tenval.center.x = self.view.center.x
        Viewpart.addSubview(tenval)
        
        tentotal.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 2 * mainSize.height/9, width: mainSize.width/6, height: 30)
        tentotal.text = "0"
        tentotal.textColor = UIColor.red
        tentotal.textAlignment = .center
//        tentotal.sizeToFit()
        tentotal.center.x = 5 * self.view.center.x / 3
        Viewpart.addSubview(tentotal)

        fifthrate.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 3 * mainSize.height/9, width: mainSize.width/6, height: 30)
        fifthrate.text = "15%"
        fifthrate.textColor = UIColor.black
        fifthrate.textAlignment = .center
//        fifthrate.sizeToFit()
        fifthrate.center.x = self.view.center.x / 3
        Viewpart.addSubview(fifthrate)
        
        fifthval.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 3 * mainSize.height/9, width: mainSize.width/6, height: 30)
        fifthval.text = "0"
        fifthval.textColor = UIColor.red
        fifthval.textAlignment = .center
//        fifthval.sizeToFit()
        fifthval.center.x = self.view.center.x
        Viewpart.addSubview(fifthval)
        
        fifthtotal.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 3 * mainSize.height/9, width: mainSize.width/6, height: 30)
        fifthtotal.text = "0"
        fifthtotal.textColor = UIColor.red
        fifthtotal.textAlignment = .center
//        fifthtotal.sizeToFit()
        fifthtotal.center.x = 5 * self.view.center.x / 3
        Viewpart.addSubview(fifthtotal)

        eightrate.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 4 * mainSize.height/9, width: mainSize.width/6, height: 30)
        eightrate.text = "18%"
        eightrate.textColor = UIColor.black
        eightrate.textAlignment = .center
//        eightrate.sizeToFit()
        eightrate.center.x = self.view.center.x / 3
        Viewpart.addSubview(eightrate)
        
        eightval.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 4 * mainSize.height/9, width: mainSize.width/6, height: 30)
        eightval.text = "0"
        eightval.textColor = UIColor.red
        eightval.textAlignment = .center
//        eightval.sizeToFit()
        eightval.center.x = self.view.center.x
        Viewpart.addSubview(eightval)
        
        eighttotal.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 4 * mainSize.height/9, width: mainSize.width/6, height: 30)
        eighttotal.text = "0"
        eighttotal.textColor = UIColor.red
        eighttotal.textAlignment = .center
//        eighttotal.sizeToFit()
        eighttotal.center.x = 5 * self.view.center.x/3
        Viewpart.addSubview(eighttotal)
        
        twenrate.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 5 * mainSize.height/9, width: mainSize.width/6, height: 30)
        twenrate.text = "20%"
        twenrate.textColor = UIColor.black
        twenrate.textAlignment = .center
//        twenrate.sizeToFit()
        twenrate.center.x = self.view.center.x / 3
        Viewpart.addSubview(twenrate)
        
        twenval.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 5 * mainSize.height/9, width: mainSize.width/6, height: 30)
        twenval.text = "0"
        twenval.textColor = UIColor.red
        twenval.textAlignment = .center
//        twenval.sizeToFit()
        twenval.center.x = self.view.center.x
        Viewpart.addSubview(twenval)
        
        twentotal.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 5 * mainSize.height/9, width: mainSize.width/6, height: 30)
        twentotal.text = "0"
        twentotal.textColor = UIColor.red
        twentotal.textAlignment = .center
//        twentotal.sizeToFit()
        twentotal.center.x = 5 * self.view.center.x/3
        Viewpart.addSubview(twentotal)
        
        otherrate.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 6 * mainSize.height/9, width: mainSize.width/6, height: 30)
        otherrate.text = "0"
        otherrate.textColor = UIColor.black
        otherrate.keyboardType = .numbersAndPunctuation
        otherrate.textAlignment = .center
//        otherrate.sizeToFit()
        otherrate.center.x = self.view.center.x / 3
        otherrate.delegate = self
        Viewpart.addSubview(otherrate)
        
        ratesymbol.frame = CGRect(x: otherrate.center.x + mainSize.width / 12, y: mainSize.height / 7 + 6 * mainSize.height/9, width: mainSize.width/12, height: 30)
        ratesymbol.text = "%"
        ratesymbol.textColor = UIColor.black
        ratesymbol.textAlignment = .center
        Viewpart.addSubview(ratesymbol)
        
        otherval.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 6 * mainSize.height/9, width: mainSize.width/6, height: 30)
        otherval.text = "0"
        otherval.textColor = UIColor.red
        otherval.keyboardType = .numbersAndPunctuation
        otherval.textAlignment = .center
//        otherval.sizeToFit()
        otherval.delegate = self
        otherval.center.x = self.view.center.x
        Viewpart.addSubview(otherval)
        
        othertotal.frame = CGRect(x: mainSize.width, y: mainSize.height / 7 + 6 * mainSize.height/9, width: mainSize.width/6, height: 30)
        othertotal.text = "0"
        othertotal.textColor = UIColor.red
        othertotal.textAlignment = .center
        othertotal.center.x = 5 * self.view.center.x/3
        Viewpart.addSubview(othertotal)
        
    }
    
    @IBAction func peonum(_ sender: Any) {
        PeoNum.text = ""
    }
    
    @IBAction func startchange(_ sender: Any) {
        res = Money.text
        Money.text = ""
    }
    
    @IBAction func startchange2(_ sender: Any) {
        res2 = otherrate.text
        otherrate.text = ""
    }
    
    @IBAction func startchange3(_ sender: Any) {
        res3 = otherrate.text
        otherval.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changevalue(_ sender: Any) {
        if PeoNum.text == "" || PeoNum.text == "0"{
            self.PeoNum.text = "1"
        }
        if Money.text == "" && res == "0" {
            Money.text = "0"
            tenval.text = "0"
            tentotal.text = "0"
            fifthval.text = "0"
            fifthtotal.text = "0"
            eightval.text = "0"
            eighttotal.text = "0"
            twenval.text = "0"
            twentotal.text = "0"
            othertotal.text = otherval.text
        }
        else if Money.text == "" && res != "0" {
            Money.text = res
        }
        else{
            var bal = Int(PeoNum.text!)!
            if bal == 0{
                bal = 1
            }
            let num:Double! = Double(Money.text!)! / Double(bal)
//            print (num)
            tenval.text = String(format: "%.2f", num! * 0.10)
            tentotal.text = String(format: "%.2f", num! * 1.10)
            fifthval.text = String(format: "%.2f", num! * 0.15)
            fifthtotal.text = String(format: "%.2f", num! * 1.15)
            eightval.text = String(format: "%.2f", num! * 0.18)
            eighttotal.text = String(format: "%.2f", num! * 1.18)
            twenval.text = String(format: "%.2f", num! * 0.20)
            twentotal.text = String(format: "%.2f", num! * 1.20)
            otherval.text = String(format: "%.2f", (Double(otherrate.text!)! / 100 * num!))
            othertotal.text = String(format: "%.2f", Double(otherrate.text!)! / 100 * num! + num!)
        }
    }
    
    
    
    
    @IBAction func changevalue2(_ sender: Any) {
        if Money.text == "0"{
            if otherval.text == "inf" || otherrate.text == "inf" || otherrate.text == "nan"{
                otherrate.text = "0"
                otherval.text = "0"
                othertotal.text = "0"
            }
            else if otherrate.text == "" && res2 == ""{
                otherrate.text = "0"
            }
            else if otherrate.text == "" && res2 != "" {
                otherrate.text = res2
            }
        }
        else{
            if otherrate.text == "" && res2 == ""{
                otherrate.text = "0"
            }
            else if otherrate.text == "" && res2 != "" {
                otherrate.text = res2
                var bal = Int(PeoNum.text!)!
                if bal == 0{
                    bal = 1
                }
                otherval.text = String(format: "%.2f", (Double(res2)! * Double(bal) /  100 / Double(Money.text!)!))
                othertotal.text = String(format: "%.2f", Double(res2)! * Double(bal) / 100 / Double(Money.text!)! + Double(Money.text!)! / Double(bal))
            }
            else{
                var bal = Int(PeoNum.text!)!
                if bal == 0{
                    bal = 1
                }
                otherval.text = String(format: "%.2f", (Double(otherrate.text!)! / Double(PeoNum.text!)! / 100 * Double(Money.text!)!))
                othertotal.text = String(format: "%.2f", Double(otherrate.text!)! / Double(bal) / 100 * Double(Money.text!)! + Double(Money.text!)! / Double(bal))
            }
        }
        
    }
    
    @IBAction func changevalue3(_ sender: Any) {
        if Money.text == "0"{
            if otherval.text == "inf" || otherrate.text == "inf" || otherrate.text == "nan"{
                otherrate.text = "0"
                otherval.text = "0"
                othertotal.text = "0"
            }
            else if otherval.text == "" && res3 == ""{
                otherval.text = "0"
            }
            else if otherval.text == "" && res3 != "" {
                otherval.text = res3
                othertotal.text = res3
            }
            else{
                othertotal.text = otherval.text
            }

        }
        else{
            if otherval.text == "" && res3 == ""{
                otherval.text = "0"
            }
            else if otherval.text == "" && res3 != "" {
                var bal = Int(PeoNum.text!)!
                if bal == 0{
                    bal = 1
                }
                otherval.text = res3
                otherrate.text = String(format: "%.2f", Double(otherval.text!)!/Double(Money.text!)!*100 * Double(bal))
                othertotal.text = String(format: "%.2f", Double(res3)! + Double(Money.text!)! / Double(bal))
            }
            else{
                var bal = Int(PeoNum.text!)!
                if bal == 0{
                    bal = 1
                }
                otherrate.text = String(format: "%.2f", Double(otherval.text!)!/Double(Money.text!)!*100 * Double(bal))
                othertotal.text = String(format: "%.2f", Double(otherval.text!)! + Double(Money.text!)! / Double(bal))
            }
        }
    }

    func hideKeyboard() -> Void{
        self.view.frame.origin.y = 0
        Money.endEditing(true)
        otherrate.endEditing(true)
        otherval.endEditing(true)
        PeoNum.endEditing(true)
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

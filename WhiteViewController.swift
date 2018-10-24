//
//  WhiteViewController.swift
//  DolphinAssistant
//
//  Created by Kaiqi Fan on 8/26/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//

import UIKit
import CoreTelephony
import MessageUI

class WhiteViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    let mailComposeVC = MFMailComposeViewController()
    let fullScreenSize = UIScreen.main.bounds.size
    let memoryTag = UserDefaults.standard
    
    let callWebView = UIWebView()
    let now = Date()
    let dformatter = DateFormatter()
    
    @IBOutlet weak var titlecontent: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var Phone1: UILabel!
    @IBOutlet weak var Phone2: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Note: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var PhoneNum1: UIButton!
    @IBOutlet weak var PhoneNum2: UIButton!
    @IBOutlet weak var EmailAdd: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailComposeVC.mailComposeDelegate = self
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if memoryTag.string(forKey: "flag") == "ON"{
            titlecontent.text = "芝加哥领事馆"
            Phone1.text = "咨询电话:"
            Phone2.text = "传真电话:"
            Email.text = "电子邮件:"
            Note.text = "(咨询电话中有关于证件办理的一般信息)"
            Address.text = "使馆地址: 1 East Erie Street, Suite 500，\nChicago, IL 60611"
        }
        else{
            titlecontent.text = "Chinese Embassy in Chicago"
            Phone1.text = "Embassy call:"
            Phone2.text = "fax Call:"
            Email.text = "Email:"
            Note.text = "(This call only has general information about the documents.)"
            Address.text = "Embassy Address: 1 East Erie Street, Suite 500，\nChicago, IL 60611"
            
        }
        background.frame = CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height)
        background.image = UIImage(named:"Action5.png")
        self.view.addSubview(background)
        
        titlecontent.frame = CGRect(x: fullScreenSize.width/5, y: fullScreenSize.height / 9 + 5, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        titlecontent.sizeToFit()
        titlecontent.textAlignment = .center
        titlecontent.center.x = fullScreenSize.width / 2
        titlecontent.center.y = fullScreenSize.height / 9 + 10
        self.view.addSubview(titlecontent)
        
        
        Phone1.frame = CGRect(x: fullScreenSize.width/5, y: 2 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        Phone1.sizeToFit()
        Phone1.textAlignment = .center
        Phone1.center.x = fullScreenSize.width / 3 - 15
        Phone1.center.y = 2 * fullScreenSize.height / 9 + 5
        self.view.addSubview(Phone1)
        
        PhoneNum1.frame = CGRect(x: fullScreenSize.width/5, y: 2 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        PhoneNum1.sizeToFit()
        PhoneNum1.center.x = 2 * fullScreenSize.width / 3
        PhoneNum1.center.y = 2 * fullScreenSize.height / 9 + 5
        self.view.addSubview(PhoneNum1)
        
        Phone2.frame = CGRect(x: fullScreenSize.width/5, y: 3 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        Phone2.sizeToFit()
        Phone2.textAlignment = .center
        Phone2.center.x = fullScreenSize.width / 3 - 15
        Phone2.center.y = 3 * fullScreenSize.height / 9
        self.view.addSubview(Phone2)
        
        PhoneNum2.frame = CGRect(x: fullScreenSize.width/5, y: 3 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        PhoneNum2.sizeToFit()
        PhoneNum2.center.x = 2 * fullScreenSize.width / 3
        PhoneNum2.center.y = 3 * fullScreenSize.height / 9
        self.view.addSubview(PhoneNum2)
        
        Note.frame = CGRect(x: fullScreenSize.width/5, y: 4 * fullScreenSize.height / 9, width: fullScreenSize.width * 4 / 5, height: fullScreenSize.width/4)
        Note.numberOfLines = 2
        Note.sizeToFit()
        Note.textAlignment = .center
        Note.center.x = fullScreenSize.width / 2
        Note.center.y = 4 * fullScreenSize.height / 9 - 10
        self.view.addSubview(Note)
        
        Email.frame = CGRect(x: fullScreenSize.width/5, y: 5 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        Email.sizeToFit()
        Email.textAlignment = .center
        Email.center.x = fullScreenSize.width / 2
        self.view.addSubview(Email)
        
        EmailAdd.frame = CGRect(x: fullScreenSize.width/5, y: 6 * fullScreenSize.height / 9, width: fullScreenSize.width * 3 / 5, height: fullScreenSize.width/4)
        EmailAdd.sizeToFit()
        EmailAdd.center.x =  fullScreenSize.width / 2
        EmailAdd.center.y = 6 * fullScreenSize.height / 9 - 10
        self.view.addSubview(EmailAdd)
        
        Address.frame = CGRect(x: fullScreenSize.width/5, y: 7 * fullScreenSize.height / 9 - 10, width: fullScreenSize.width * 4 / 5, height: fullScreenSize.width/3)
        Address.numberOfLines = 4
        Address.sizeToFit()
        Address.textAlignment = .center
        Address.center.x = fullScreenSize.width / 2
        self.view.addSubview(Address)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func phone1(_ sender: Any) {
        let number = "(312)453-0210"
        callWebView.loadRequest(URLRequest(url:URL(string: "tel:\(number)")!))
        UIApplication.shared.open(URL(string:number)!, options: ["":""], completionHandler: nil)
    }
    
    @IBAction func phone2(_ sender: Any) {
        let number = "(312)453-0211"
        callWebView.loadRequest(URLRequest(url:URL(string: "tel:\(number)")!))
        UIApplication.shared.open(URL(string:number)!, options: ["":""], completionHandler: nil)
    }
    
    
    
    @IBAction func gotoEmail(_ sender: UIButton) {
        dformatter.dateFormat = "MMM d, yyyy"
        
        if MFMailComposeViewController.canSendMail() {
            //注意这个实例要写在if block里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
            let mailComposeViewController = configuredMailComposeViewController()
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        //设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["chinavisachicago@gmail.com"])
        mailComposeVC.setSubject("")
        mailComposeVC.setMessageBody("\n\(dformatter.string(from: now)) \n", isHTML: false)
        return mailComposeVC
        
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在“邮件”应用中设置后再尝试发送。", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            let alertController = UIAlertController(title: "邮件发送已取消", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "关闭", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        case MFMailComposeResult.sent.rawValue:
            let alertController = UIAlertController(title: "邮件发送成功", message: "谢谢", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "关闭", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
        
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

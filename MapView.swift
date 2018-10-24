//
//  MapView.swift
//  Help
//
//  Created by Kaiqi Fan on 5/31/17.
//  Copyright © 2017 Kaiqi Fan. All rights reserved.
//
import UIKit

class MapViewController: UIViewController {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet weak var naCon: UINavigationBar!
    @IBOutlet weak var mapTitle: UINavigationItem!
    @IBOutlet weak var scrollImg: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var oldPoint: CGPoint = CGPoint(x: 0, y: 0)
    var oldScale: CGFloat = 1
    var urlString: String = ""
    
    let memoryTag = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        naCon.isTranslucent = true
        naCon.setBackgroundImage(UIImage(), for: .default)
        naCon.shadowImage = UIImage()
        
        scrollImg.delegate = self as? UIScrollViewDelegate
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        
        imageView.clipsToBounds = false
        
        mapTitle.title = memoryTag.string(forKey: "Map")!
        
        switch memoryTag.string(forKey: "Map")! {
        case "纽约","New York":
            imageView.image = UIImage(named: "nycsubway.jpg")
            urlString = "http://www.mta.info/"
        case "华盛顿特区","Washington DC":
            imageView.image = UIImage(named: "washdcsubway.jpg")
            urlString = "http://www.transitchicago.com/"
        case "芝加哥","Chicago":
            imageView.image = UIImage(named: "chicagosubway.png")
            urlString = "https://www.bart.gov/"
        case "波士顿","Boston":
            imageView.image = UIImage(named: "bostonsubway.jpg")
            urlString = "http://www.itsmarta.com/"
        case "旧金山","San Francisco":
            imageView.image = UIImage(named: "sanfransubway.jpg")
            urlString = "https://www.wmata.com/"
        case "费城","Philadelphia":
            imageView.image = UIImage(named: "philsubway.jpg")
            urlString = "http://www.mbta.com/"
        case "亚特兰大","Atlanta":
            imageView.image = UIImage(named: "atlantasubway.jpg")
            urlString = "http://www.septa.org/"
        case "洛杉矶","Los Angeles":
            imageView.image = UIImage(named: "lasubway.jpg")
            urlString = "https://www.metro.net/"
        default:
            break
        }
        
        
        let zoom = UIPinchGestureRecognizer(target: self, action: #selector(self.zoom))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        scrollImg.addGestureRecognizer(pan)
        scrollImg.addGestureRecognizer(zoom)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func pan(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: self.view)
        if oldPoint == CGPoint(x: 0, y: 0) {
            oldPoint = point
            return
        }
        
        let xdiff = oldPoint.x - point.x
        let ydiff = oldPoint.y - point.y
        
        if imageView.center.x < imageView.frame.size.width / 2 && imageView.center.x + imageView.frame.size.width / 2 < self.view.frame.size.width && xdiff > 0 {
            
        } else if imageView.center.x > imageView.frame.size.width / 2 && imageView.center.x + imageView.frame.size.width / 2 > self.view.frame.size.width && xdiff < 0 {
            
        } else {
            imageView.center.x = imageView.center.x - xdiff
        }
        
        if imageView.center.y < imageView.frame.size.height / 2 && imageView.center.y + imageView.frame.size.height / 2 + 64 /* Compensate nav bar */ < self.view.frame.size.height && ydiff > 0 {
            
        } else if imageView.center.y > imageView.frame.size.height / 2 && imageView.center.y + imageView.frame.size.height / 2 > self.view.frame.size.height && ydiff < 0 {
            
        } else {
            imageView.center.y = imageView.center.y - ydiff
        }
        oldPoint = point
        
        
        if recognizer.state == .ended {
            oldPoint = CGPoint(x: 0, y: 0)
            if (tellSection()[0] == "left") {imageView.center.x = imageView.frame.size.width / 2}
            if (tellSection()[0] == "right") {imageView.center.x = self.view.frame.size.width - imageView.frame.size.width / 2}
            if (tellSection()[1] == "up") {imageView.center.y = imageView.frame.size.height / 2}
            if (tellSection()[1] == "down") {imageView.center.y = self.view.frame.size.height - imageView.frame.size.height / 2 - 64}
        }
    }
    
    func zoom(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .changed {
        
            let currentScale = self.imageView.frame.size.width / self.imageView.bounds.size.width
            var newScale = currentScale * recognizer.scale
            
            if newScale < 1 {
                newScale = 1
            } else if newScale > 4 {
                newScale = 4
            }
            
            let xMin = imageView.frame.minX
            let yMin = imageView.frame.minY
            
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            
            self.imageView.transform = transform
            
            if (newScale < oldScale) {
                let xDiff = imageView.frame.size.width * (newScale - oldScale) / newScale
                let yDiff = imageView.frame.size.height * (newScale - oldScale) / newScale
                
                var xFactor = 0 as CGFloat
                var yFactor = 0 as CGFloat
                
                if tellPinch(recognizer: recognizer)[0] == "mid" {
                    xFactor = -1
                } else if tellPinch(recognizer: recognizer)[0] == "right" {
                    xFactor = -2
                } else {xFactor = 0}
                
                if tellPinch(recognizer: recognizer)[1] == "mid" {
                    yFactor = -1
                } else if tellPinch(recognizer: recognizer)[1] == "down" {
                    yFactor = -2
                } else {yFactor = 0}
                
                
                imageView.frame = CGRect(x: xMin + xDiff * xFactor , y: yMin + yDiff * yFactor, width: imageView.frame.size.width * (newScale / oldScale), height: imageView.frame.size.height * (newScale / oldScale))
            }
            
            if (newScale > oldScale) {
                let xDiff = imageView.frame.size.width * (newScale - oldScale) / newScale
                let yDiff = imageView.frame.size.height * (newScale - oldScale) / newScale
                
                var xFactor = 0 as CGFloat
                var yFactor = 0 as CGFloat
                
                if tellPinch(recognizer: recognizer)[0] == "mid" {
                    xFactor = -1
                } else if tellPinch(recognizer: recognizer)[0] == "right" {
                    xFactor = -2
                } else {xFactor = 0}
                
                if tellPinch(recognizer: recognizer)[1] == "mid" {
                    yFactor = -1
                } else if tellPinch(recognizer: recognizer)[1] == "down" {
                    yFactor = -2
                } else {yFactor = 0}
                
                imageView.frame = CGRect(x: xMin + xDiff * xFactor, y: yMin + yDiff * yFactor, width: imageView.frame.size.width * (newScale / oldScale), height: imageView.frame.size.height * (newScale / oldScale))
                
            }
            
            oldScale = newScale
            recognizer.scale = 1
            
            if (tellSection()[0] == "left") {imageView.center.x = imageView.frame.size.width / 2}
            if (tellSection()[0] == "right") {imageView.center.x = self.view.frame.size.width - imageView.frame.size.width / 2}
            if (tellSection()[1] == "up") {imageView.center.y = imageView.frame.size.height / 2}
            if (tellSection()[1] == "down") {imageView.center.y = self.view.frame.size.height - imageView.frame.size.height / 2 - 64}
        }
        
    }
    
    func tellSection() -> Array<String> {
        let img = imageView.frame
        let base = self.view.frame
        var result = Array<String> ()
        
        if img.maxX <= base.maxX && img.minX < base.minX {
            result.append("right")
        } else if img.maxX > base.maxX && img.minX >= base.minX {
            result.append("left")
        } else {
            result.append("mid")
        }
        
        if img.maxY <= base.maxY && img.minY < base.minY {
            result.append("down")
        } else if img.maxY > base.maxY && img.minY >= base.minY {
            result.append("up")
        } else {
            result.append("mid")
        }
        
        return result
    }
    
    func tellPinch(recognizer: UIPinchGestureRecognizer) -> Array<String> {
        let point1 = recognizer.location(ofTouch: 0, in: self.view)
        let point2 = recognizer.location(ofTouch: 1, in: self.view)
        let midpoint = CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
        
        var result = Array<String> ()
        
        if midpoint.x > 1.5 * self.view.center.x {
            result.append("right")
        } else if midpoint.x < 0.66 * self.view.center.x {
            result.append("left")
        } else {result.append("mid")}
        
        if midpoint.y > 1.5 * self.view.center.y {
            result.append("down")
        } else if midpoint.y < 0.66 * self.view.center.y {
            result.append("up")
        } else {result.append("mid")}
        
        return result
    }
    
    @IBAction func moreInfo(_ sender: UIBarButtonItem) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

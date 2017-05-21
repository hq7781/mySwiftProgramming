//
//  DetailViewController.swift
//  mySwfitProgramming
//
//  Created by enixapp on 5/16/17.
//  Copyright © 2017 enixsoft. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
 
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        self.view.backgroundColor = UIColor.white
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                // HONG label.text = detail.value(forKey: "timeStamp")!.description
                label.text = (detail.value(forKey: "timeStamp") as! NSObject).description
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        self.showDeviceDisplayInfoView()
        
        self.showOpreationView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.onOrientationChange(notification:)),
                                               name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - show Opreation View
    func showOpreationView() {
        // Update the user interface for the detail item.
        self.showOpreationDemo1Button()
        self.showOpreationDemo2Button()
        self.showOpreationDemo3Button()
    }

    func showOpreationDemo1Button() {
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        myButton.backgroundColor = UIColor.blue
        myButton.setTitle("DemoToutchID開始", for: UIControlState())
        myButton.setTitleColor(UIColor.white, for: UIControlState())
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height - 100)
        myButton.addTarget(self, action: #selector(DetailViewController.onClickDemoButton), for: .touchUpInside)
        
        self.view.addSubview(myButton)
    }

    func showOpreationDemo2Button() {
        let myButton2 = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        myButton2.backgroundColor = UIColor.blue
        myButton2.setTitle("ViewDrag開始", for: UIControlState())
        myButton2.setTitleColor(UIColor.white, for: UIControlState())
        myButton2.layer.masksToBounds = true
        myButton2.layer.cornerRadius = 20.0
        myButton2.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height - 200)
        myButton2.addTarget(self, action: #selector(DetailViewController.onClickDemo2Button), for: .touchUpInside)

        self.view.addSubview(myButton2)
    }

    func showOpreationDemo3Button() {
        let myButton3 = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        myButton3.backgroundColor = UIColor.blue
        myButton3.setTitle("SubBotton開始", for: UIControlState())
        myButton3.setTitleColor(UIColor.white, for: UIControlState())
        myButton3.layer.masksToBounds = true
        myButton3.layer.cornerRadius = 20.0
        myButton3.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height - 300)
        myButton3.addTarget(self, action: #selector(DetailViewController.onClickDemo3Button), for: .touchUpInside)

        self.view.addSubview(myButton3)
    }
    
    func onClickDemoButton() {
        // 遷移するViewを定義する.
        let nextViewController: UIViewController = DemoToutchIDViewController()
        // アニメーションを設定する.
        nextViewController.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        // Viewの移動する.
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    func onClickDemo2Button() {
        // 遷移するViewを定義する.
        let nextViewController: UIViewController = DemoViewDragViewController()
        // アニメーションを設定する.
        nextViewController.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        // Viewの移動する.
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    func onClickDemo3Button() {
        // 遷移するViewを定義する.
        let nextViewController: UIViewController = DemoShowSubButtonViewController()
        // アニメーションを設定する.
        nextViewController.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        // Viewの移動する.
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    func showDeviceDisplayInfoView() {
        
        // Windowの表示領域すべてのサイズ(point).
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        let myBoundSizeStr: NSString = "Bounds width: \(myBoundSize.width) height: \(myBoundSize.height)" as NSString
        print("\(myBoundSizeStr)")
        setMyLabel(text: myBoundSizeStr, point: CGPoint(x: 0, y: 100))
        
        // Windowの表示領域すべてのサイズ(pixel).
        let myNativeBoundSize: CGSize = UIScreen.main.nativeBounds.size
        let myNativeBoundSizeStr: NSString = "NativeBounds width: \(myNativeBoundSize.width) \nNativeBoundheight: \(myNativeBoundSize.height)" as NSString
        print("\(myNativeBoundSizeStr)")
        setMyLabel(text: myNativeBoundSizeStr, point: CGPoint(x: 0, y: 200))

        // Windowの表示領域すべてのサイズ(pixel).
        let myAppFrameSize: CGSize = UIScreen.main.bounds.size
        let myAppFrameSizeStr: NSString = "applicationFrame width: \(myAppFrameSize.width) \nNativeBoundheight: \(myAppFrameSize.height)" as NSString
        print("\(myAppFrameSizeStr)")
        setMyLabel(text: myAppFrameSizeStr, point: CGPoint(x: 0, y: 300))
        
        // WindowのScale.
        let myScale: CGFloat = UIScreen.main.scale
        print("\(myScale)")
        setMyLabel(text: "\(myScale)" as NSString, point: CGPoint(x: 0, y: 400))

    }
    
    // ラベルの表示.
    func setMyLabel(text: NSString, point: CGPoint){
        let myLabel = UILabel(frame: CGRect(x:point.x,y:point.y,width:self.view.bounds.width,height:50))
        myLabel.backgroundColor = UIColor.orange
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 10.0
        myLabel.textColor = UIColor.white
        myLabel.shadowColor = UIColor.gray
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.font = UIFont.systemFont(ofSize: 14)
        myLabel.text = text as String
        myLabel.numberOfLines = 2
        self.view.addSubview(myLabel)
    }
    
    // 端末の向きがかわったら呼び出される.
    func onOrientationChange(notification: NSNotification){
        
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.current.orientation
        // 向きの判定.
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定. 向きに従って位置を調整する.
            print("Landscape")
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定. 向きに従って位置を調整する.
            print("Portrait")
        }
        self.configureView()
        self.showDeviceDisplayInfoView()
        self.showOpreationView()
    }

}


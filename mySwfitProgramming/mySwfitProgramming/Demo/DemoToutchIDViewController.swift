//
//  DemoToutchIDViewController.swift
//  mySwfitProgramming
//
//  Created by recomot on 5/16/17.
//  Copyright © 2017 enixsoft. All rights reserved.
//

import UIKit
import LocalAuthentication

class DemoToutchIDViewController: UIViewController {
    // 認証用コンテキスト.
    var myAuthContext : LAContext!
    var mySecurityLabel : UILabel!
    var myButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myAuthContext = LAContext()
        
        mySecurityLabel = UILabel(frame: CGRectMake(0, 0, 150, 150))
        mySecurityLabel.backgroundColor = UIColor.orangeColor()
        mySecurityLabel.layer.masksToBounds = true
        mySecurityLabel.layer.cornerRadius = 75.0
        mySecurityLabel.textColor = UIColor.whiteColor()
        mySecurityLabel.shadowColor = UIColor.grayColor()
        mySecurityLabel.font = UIFont.systemFontOfSize(CGFloat(30))
        mySecurityLabel.textAlignment = NSTextAlignment.Center
        mySecurityLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: 300)
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(mySecurityLabel)
        
        myButton = UIButton(frame: CGRectMake(0, 0, 200, 50))
        myButton.setTitle("認証開始", forState: .Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myButton.backgroundColor = UIColor.blueColor()
        myButton.addTarget(self, action: #selector(DemoToutchIDViewController.checkSuccess), forControlEvents: .TouchUpInside)
        myButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y: 60)
        self.view.addSubview(myButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func updateMySecurityLabel(success: Bool) {
        dispatch_async(dispatch_get_main_queue(),{
            if success {
                print("認証成功")
                self.mySecurityLabel.text = "認証成功"
            } else {
                print("認証失敗")
                self.mySecurityLabel.text = "認証失敗"
            }
        })
    }

    func checkSuccess() {
        
        if myAuthContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil) {
            myAuthContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                                         localizedReason: "テスト認証",
                                         reply: {
                                            // HONG (success: Bool, error: NSError!) -> Void in
                                            (success: Bool, error: NSError?) -> Void in
                                            self.updateMySecurityLabel(success)
            })
        }
    }
    
    // MARK: - show Opreation View
    func showOpreationView() {
        // 背景色を設定.
        self.view.backgroundColor = UIColor.blueColor()
        
        // ボタンを作成.
        let backButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        backButton.backgroundColor = UIColor.redColor();
        backButton.layer.masksToBounds = true
        backButton.setTitle("Back", forState: .Normal)
        backButton.layer.cornerRadius = 20.0
        //backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        backButton.addTarget(self, action: #selector(DemoToutchIDViewController.onClickBackButton(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton);
    }

    func onClickBackButton(sender: UIButton){
        
        // 遷移するViewを定義.
        let prevController: UIViewController = DetailViewController()
        
        // アニメーションを設定.
        prevController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        // Viewの移動.
        self.presentViewController(prevController, animated: true, completion: nil)
    }


}

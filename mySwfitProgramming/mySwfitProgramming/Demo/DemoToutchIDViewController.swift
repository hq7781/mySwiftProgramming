//
//  DemoToutchIDViewController.swift
//  mySwfitProgramming
//
//  Created by enixapp on 5/16/17.
//  Copyright © 2017 enixsoft. All rights reserved.
//

import UIKit
import LocalAuthentication

@available(iOS 8.0, *)
class DemoToutchIDViewController: UIViewController {
    // 認証用コンテキスト.
    var myAuthContext : LAContext!
    var mySecurityLabel : UILabel!
    var myButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myAuthContext = LAContext()
        // 背景色を設定.
        self.view.backgroundColor = UIColor.black
        
        mySecurityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        mySecurityLabel.backgroundColor = UIColor.orange
        mySecurityLabel.layer.masksToBounds = true
        mySecurityLabel.layer.cornerRadius = 75.0
        mySecurityLabel.textColor = UIColor.white
        mySecurityLabel.shadowColor = UIColor.gray
        mySecurityLabel.font = UIFont.systemFont(ofSize: CGFloat(30))
        mySecurityLabel.textAlignment = NSTextAlignment.center
        mySecurityLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: 300)
        self.view.addSubview(mySecurityLabel)
        
        myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        myButton.backgroundColor = UIColor.blue
        myButton.setTitle("認証開始", for: UIControlState())
        myButton.setTitleColor(UIColor.white, for: UIControlState())
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height-200)
        myButton.addTarget(self, action: #selector(DemoToutchIDViewController.checkSuccess), for: .touchUpInside)
        self.view.addSubview(myButton)
        
        self.showOpreationView()
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
    func updateMySecurityLabel(_ success: Bool) {
        DispatchQueue.main.async(execute: {
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
        self.mySecurityLabel.text = ""
        if myAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            myAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                         localizedReason: "このアプリの利用には認証が必要です",
                                         reply: {
                                            (success: Bool, error: Error?) -> Void in
                                            let nserror = error as! NSError
                                            self.updateMySecurityLabel(success)
                                            print("Touch ID Auth result: %@", error.debugDescription)
                                            if (success) {
                                            } else {
                                                print("Touch ID Auth Failed!")
                                                switch nserror._code {
                                                case LAError.authenticationFailed.rawValue: //kLAErrorAuthenticationFailed:
                                                    print("Touch ID Auth result: kSecUseAuthenticationUIFail")
                                                case LAError.userCancel.rawValue: //kLAErrorUserCancel:
                                                    print("Touch ID Auth result: kLAErrorUserCancel")
                                                case LAError.userFallback.rawValue: //kLAErrorUserFallback:
                                                    print("Touch ID Auth result: kLAErrorUserFallback")
                                                    self.myAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication,
                                                                                      localizedReason: "パスコードを入力してください",
                                                                                      reply: {
                                                                                        (success: Bool, error: Error?) -> Void in
                                                                                        self.updateMySecurityLabel(success)
                                                                                        print("passcode Auth result: %@", error.debugDescription)
                                                                                        if (success) {
                                                                                        } else {
                                                                                            print("Passcode Auth Failed!")
                                                                                        }
                                                    })
                                                case LAError.systemCancel.rawValue: //kLAErrorSystemCancel:
                                                    print("Touch ID Auth result: kLAErrorSystemCancel")
                                                case LAError.passcodeNotSet.rawValue: //kLAErrorPasscodeNotSet:
                                                    print("Touch ID Auth result: kLAErrorPasscodeNotSet")
                                                case LAError.touchIDNotAvailable.rawValue:// kLAErrorTouchIDNotAvailable:
                                                    print("Touch ID Auth result: kLAErrorTouchIDNotAvailable")
                                                case LAError.touchIDNotEnrolled.rawValue: //kLAErrorTouchIDNotEnrolled:
                                                    print("Touch ID Auth result: kLAErrorTouchIDNotEnrolled")
                                                default: break
                                                }
                                                
                                            }
            })
        } else {
            print("not support Touch ID Auth ")
            self.myAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication,
                                              localizedReason: "パスコードを入力してください",
                                              reply: {
                                                (success: Bool, error: Error?) -> Void in
                                                self.updateMySecurityLabel(success)
                                                print("passcode Auth result: %@", error.debugDescription)
                                                if (success) {
                                                    self.showOKAlert()
                                                } else {
                                                    print("Passcode Auth Failed!")
                                                }
            })
        }
    }
    
    // MARK: - show Opreation View
    func showOpreationView() {

        // ボタンを作成.
        let backButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 120,height: 50))
        backButton.backgroundColor = UIColor.red;
        backButton.setTitle("Back", for: UIControlState())
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 20.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-100)
        backButton.addTarget(self, action: #selector(DemoToutchIDViewController.onClickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton);
    }

    func onClickBackButton(_ sender: UIButton){
        
        // 遷移するViewを定義.
        let prevController: UIViewController = DetailViewController()
        // アニメーションを設定.
        prevController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        // Viewの移動.
        self.present(prevController, animated: true, completion: nil)
    }
    
    func showOKAlert() {
        
        let alertController = UIAlertController(title: "成功",message: "指紋認証に成功",preferredStyle: .alert)
        let okButton:UIAlertAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.default,handler:{(action:UIAlertAction!) -> Void in
            
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier:"next") as! DetailViewController
            self.present(nextView, animated: true, completion: nil)
        })
        
        alertController.addAction(okButton) 
        present(alertController, animated: true, completion:nil) 
    }

}

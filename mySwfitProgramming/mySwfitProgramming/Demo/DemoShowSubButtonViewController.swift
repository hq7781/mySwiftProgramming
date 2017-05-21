//
//  DemoShowSubButtonViewController.swift
//  mySwiftProgramming
//
//  Created by HongQuan on 2017/05/21.
//  Copyright © 2017年 enixsoft. All rights reserved.
//

import UIKit

class DemoShowSubButtonViewController: UIViewController {
    var mainButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.showOpreationView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - show Opreation View
    func showOpreationView() {
        // Update the user interface for the detail item.
        self.showOpreationMainButton()
    }
    
    func showOpreationMainButton() {
        // mainボタン生成.
        mainButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainButton.center = self.view.center
        
        // myCustomButtonクラスのインスタンス生成.
        let myCusButton: DemoShowSubButton = DemoShowSubButton(frame: self.view.frame)
        myCusButton.mainButton = self.mainButton
        myCusButton.mainPosition = self.mainButton.layer.position
        
        // インスタンスをviewに追加.
        self.view.addSubview(myCusButton)
        
        // mainボタン各設定.
        mainButton.layer.masksToBounds = true
        mainButton.layer.cornerRadius = 50.0
        mainButton.backgroundColor = UIColor.red
        mainButton.setTitle("Fire!", for: .normal)
        mainButton.setTitleColor(UIColor.white, for: .normal)
        mainButton.addTarget(myCusButton, action: #selector(myCusButton.onDownMainButton(sender:)), for: UIControlEvents.touchUpInside)
        mainButton.addTarget(myCusButton, action: #selector(myCusButton.onUpMainButton(sender:)), for: [.touchUpInside, .touchDragOutside])
        mainButton.tag = 0
        
        // mainボタンをviewに追加.
        self.view.addSubview(mainButton)
    }

}

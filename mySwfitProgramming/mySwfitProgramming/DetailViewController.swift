//
//  DetailViewController.swift
//  mySwfitProgramming
//
//  Created by recomot on 5/16/17.
//  Copyright © 2017 enixsoft. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var myButton : UIButton!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        self.showOpreationView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - show Opreation View
    func showOpreationView() {
        // Update the user interface for the detail item.

        myButton = UIButton(frame: CGRectMake(0, 0, 200, 50))
        myButton.setTitle("Demo開始", forState: .Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myButton.backgroundColor = UIColor.blueColor()
        myButton.addTarget(self, action: #selector(DetailViewController.onClickDemoButton), forControlEvents: .TouchUpInside)
        //myButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y: 60)
        myButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y: 260)
        self.view.addSubview(myButton)
    }
    func onClickDemoButton() {
        // 遷移するViewを定義する.
        let nextViewController: UIViewController = DemoToutchIDViewController()
        
        // アニメーションを設定する.
        nextViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(nextViewController, animated: true, completion: nil)
        
    }

}


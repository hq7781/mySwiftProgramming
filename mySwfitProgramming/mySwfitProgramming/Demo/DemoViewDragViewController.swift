//
//  DemoViewDragViewController.swift
//  mySwiftProgramming
//
//  Created by HongQuan on 2017/05/21.
//  Copyright © 2017年 enixsoft. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class DemoViewDragViewController: UIViewController {
    
    var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        self.setMyLabel(text: "Drag It!", point: CGPoint(x: 0, y: 400))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ラベルの表示.
    func setMyLabel(text: NSString, point: CGPoint){
        //let
        myLabel = UILabel(frame: CGRect(x: point.x, y: point.y, width:self.view.bounds.width, height:50))
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
    
    
    /*
     タッチを感知した際に呼ばれるメソッド.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        
        // Labelアニメーション.
        UIView.animate(withDuration: 0.06,
                // アニメーション中の処理.
                animations: { () -> Void in
                // 縮小用アフィン行列を作成する.
                self.myLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
        { (Bool) -> Void in
        }
    }
    
    /*
     ドラッグを感知した際に呼ばれるメソッド.
     (ドラッグ中何度も呼ばれる)
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesMoved")
        // タッチイベントを取得.
        let aTouch: UITouch = touches.first!
        // 移動した先の座標を取得.
        let location = aTouch.location(in: self.view)
        // 移動する前の座標を取得.
        let prevLocation = aTouch.previousLocation(in: self.view)
        // CGRect生成.
        var myFrame: CGRect = self.view.frame
        // ドラッグで移動したx, y距離をとる.
        let deltaX: CGFloat = location.x - prevLocation.x
        let deltaY: CGFloat = location.y - prevLocation.y
        
        // 移動した分の距離をmyFrameの座標にプラスする.
        myFrame.origin.x += deltaX
        myFrame.origin.y += deltaY
        
        // frameにmyFrameを追加.
        self.view.frame = myFrame
    }
    
    /*
     指が離れたことを感知した際に呼ばれるメソッド.
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesEnded")
        // Labelアニメーション.
        UIView.animate(withDuration: 0.1,
            // アニメーション中の処理.
            animations: { () -> Void in
                // 拡大用アフィン行列を作成する.
                self.myLabel.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                // 縮小用アフィン行列を作成する.
                self.myLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        { (Bool) -> Void in
            
        }
    }
    
}

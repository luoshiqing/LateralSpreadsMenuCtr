//
//  OneViewController.swift
//  LeftNav
//
//  Created by sqluo on 2017/3/7.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit


//滑动留下的边缘宽度
let keepWidth: CGFloat = 60

class OneViewController: UIViewController {

    //滑动的状态
    enum PanState {
        case Left   //到达左滑极限
        case normal //正常的
        case keep   //保留的
    }
    
    //记录偏移量
    fileprivate var nextTranslation = CGPoint(x: 0, y: 0)
    
    //动画时间
    public var animateDuration: TimeInterval = 0.2
  
    
    //MARK:属性视图
    fileprivate var mainView: UIView!
    fileprivate var leftView: UIView?
    //主视图点击事件
    var mainTap: UITapGestureRecognizer!
    //滑动状态
    fileprivate var panState = PanState.normal
 
    
    init(mainView: UIView, leftView: UIView?){
        super.init(nibName: nil, bundle: nil)
        
        self.mainView = mainView
        self.leftView = leftView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "One"
        
        if self.leftView != nil {
            
            //重新设置偏移
            //向左偏移自身一半的宽度
            self.leftView?.frame.origin.x = -self.leftView!.frame.width / 2.0
            //向上偏移导航栏高度
            self.leftView?.frame.origin.y = -64
            
            self.view.addSubview(self.leftView!)
        }

        self.view.addSubview(mainView)
        
        //给中间主视图添加拖动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan(_:)))
        self.mainView.addGestureRecognizer(pan)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @objc fileprivate func pan(_ send: UIPanGestureRecognizer){
        
        let translation = send.translation(in: self.mainView)
        let transX = nextTranslation.x + translation.x
        //print(transX)
        
        if transX < 0 {
            //print("左侧禁止滑动")
            self.panState = .Left
            
        }else if transX > WIDTH - keepWidth{
            //print("到达保留的宽度了")
            self.panState = .keep
        }else{
            self.panState = .normal
            self.mainView.transform = CGAffineTransform(translationX: transX, y: 0)
            
            self.moveNav(to: transX)
            
            self.moveTabBar(to: transX)
            
            self.moveLeftView(to: transX)
        }
 
        //拖动停止时
        if send.state == .ended{

            self.updateViewTranslation(self.panState, transX: translation.x)
        }
        
    }
    
    
    fileprivate func updateViewTranslation(_ state: PanState, transX: CGFloat){
        
        //print("起始：\(self.nextTranslation.x)")
        
        //print("transX=\(nextTranslation.x + transX)")
        
        //一半宽度
        let halfWidth: CGFloat = (WIDTH - keepWidth) / 2.0
        //print("一半宽度:\(halfWidth)")
        
        switch state {
        case .normal:
            //print("normal")
            
            //是从左往右滑动
            if self.nextTranslation.x < 3{
                
                nextTranslation.x += transX
                
                if self.nextTranslation.x > halfWidth { //超出一半，往右边滑动
                    self.open()
                }else{
                    self.close()
                }
 
                
            }else if self.nextTranslation.x > WIDTH - keepWidth - 3{
                //右往左
                nextTranslation.x += transX
                
                //往左滑，应该x为 WIDTH - keepWidth - nextTranslation.x
                
                let tX = WIDTH - keepWidth - nextTranslation.x
                
                if tX > halfWidth { //超出一半，往右边滑动
                    self.close()
                }else{
                    self.open()
                }

            }

        case .keep:
            //print("keep")
            self.open()
        case .Left:
            //print("Left")
            self.close()
        }
   
    }
    //移动左侧视图
    fileprivate func moveLeftView(to transX: CGFloat){
        
        if self.leftView != nil{
            //主视图需要移动到右边的距离
            let w = WIDTH - keepWidth
            //左视图需要移动到右边的距离
            let p = w - self.leftView!.frame.width / 2.0
            /*
             leftP / p = transX / w
             //需要移动到x的左边点为
             ==> leftP = transX / w * p
             */
            //由于开始向左偏移了 本身宽度一半，所以还得加上开始的 偏移
            let x = -self.leftView!.frame.width / 2.0 + (transX * p / w)

            self.leftView?.frame.origin.x = x
        }
    }
    
    
    //移动导航栏
    fileprivate func moveNav(to transX: CGFloat){
        
        let nav = self.navigationController?.navigationBar
        
        nav?.frame.origin.x = transX
        
    }
    //移动tabBar
    fileprivate func moveTabBar(to transX: CGFloat){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tabBar = appDelegate.rootVC!.tabBar
        
        tabBar.frame.origin.x = transX
    }
    
    //MARK:打开，关闭
    //关闭
    public func close(){
        self.nextTranslation.x = 0

        UIView.animate(withDuration: animateDuration, delay: 0, options: .curveEaseInOut, animations: { 
            self.mainView.transform = CGAffineTransform(translationX: self.nextTranslation.x, y: 0)
            self.moveNav(to: self.nextTranslation.x)
            self.moveTabBar(to: self.nextTranslation.x)
            self.moveLeftView(to: self.nextTranslation.x)
        }) { (isOK) in
            self.removeTapOfMainViewRemoveTap()
        }
    }
    //打开
    public func open(){
        self.nextTranslation.x = WIDTH - keepWidth

        UIView.animate(withDuration: animateDuration, delay: 0, options: .curveEaseInOut, animations: { 
            self.mainView.transform = CGAffineTransform(translationX: self.nextTranslation.x, y: 0)
            self.moveNav(to: self.nextTranslation.x)
            self.moveTabBar(to: self.nextTranslation.x)
            self.moveLeftView(to: self.nextTranslation.x)
        }) { (isOK) in
            self.addTapOfMainView()
        }
        
        
    }
    //给主视图添加点击事件
    fileprivate func addTapOfMainView(){
        if self.mainTap == nil {
            self.mainTap = UITapGestureRecognizer(target: self, action: #selector(self.mainViewTouch(_:)))
            self.mainView.addGestureRecognizer(self.mainTap)
        }
    }
    //
    fileprivate func removeTapOfMainViewRemoveTap(){
        if self.mainTap != nil {
            self.mainView.removeGestureRecognizer(self.mainTap)
            self.mainTap = nil
        }
    }
    //点击
    @objc fileprivate func mainViewTouch(_ send: UITapGestureRecognizer){
        self.close()
    }
    
    
    
    

}

//
//  RootTabBarController.swift
//  LeftNav
//
//  Created by sqluo on 2017/3/7.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit


let WIDTH = UIScreen.main.bounds.width
let HEIGHT = UIScreen.main.bounds.height

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.creatSubViewCtrs()
        
        
        self.tabBar.backgroundColor = UIColor.groupTableViewBackground
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    fileprivate func creatSubViewCtrs(){
    
    
        let mainV = MainView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT - 44 - 64))
        mainV.backgroundColor = UIColor.green
        
        let leftV = LeftView(frame: CGRect(x: 0, y: 0, width: WIDTH - keepWidth, height: HEIGHT))
        leftV.backgroundColor = UIColor.yellow
        //1.
        let oneVC = OneViewController(mainView: mainV, leftView: leftV)
        let one = UINavigationController(rootViewController: oneVC)
        one.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        one.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        
        
        one.tabBarItem = UITabBarItem(title: "第一", image: UIImage(named: "homeA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homeL")?.withRenderingMode(.alwaysOriginal))
        
        
        
        //2.
        let towVC = TowViewController()
        let tow = UINavigationController(rootViewController: towVC)
        tow.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        tow.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        tow.tabBarItem = UITabBarItem(title: "第二", image: UIImage(named: "reportA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "reportL")?.withRenderingMode(.alwaysOriginal))
        

        
        //3.
        let threeVC = ThreeViewController()
        let three = UINavigationController(rootViewController: threeVC)
        three.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        three.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        three.tabBarItem = UITabBarItem(title: "第三", image: UIImage(named: "messageA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "messageL")?.withRenderingMode(.alwaysOriginal))
        //4.
        let fourVC = FourViewController()
        let four = UINavigationController(rootViewController: fourVC)
        four.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        four.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        four.tabBarItem = UITabBarItem(title: "第亖", image: UIImage(named: "shopA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "shopL")?.withRenderingMode(.alwaysOriginal))
        //添加到控制器数组
        let tabArray = [one,tow,three,four]
        self.viewControllers = tabArray
        //设置文字的颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)

    }

}

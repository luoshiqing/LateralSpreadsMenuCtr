//
//  LeftView.swift
//  LeftNav
//
//  Created by sqluo on 2017/3/9.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

class LeftView: UIView ,UITableViewDelegate ,UITableViewDataSource{

    
    
    fileprivate var myTabView: UITableView?
    
    fileprivate var dataArray = Array<String>(repeating: "", count: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.initTabView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    fileprivate func initTabView(){
        let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        myTabView = UITableView(frame: rect, style: .plain)
        myTabView?.delegate = self
        myTabView?.dataSource = self
        myTabView?.tableFooterView = UIView()
        
        self.addSubview(myTabView!)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: tableViewCellIdentifier)
        }
        
        cell?.accessoryType = .disclosureIndicator
        
        
        cell?.textLabel?.text = "\(indexPath.row)搜房举案说"
        cell?.detailTextLabel?.text = "\(indexPath.row)的说法是否太让方流口水的积分案说"
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let ctr = self.parentViewController() as? OneViewController{
            print(ctr)
            let tmpVC = TmpViewController()
            tmpVC.hidesBottomBarWhenPushed = true
            
            ctr.close()
            
            ctr.navigationController?.pushViewController(tmpVC, animated: true)
        }
        
    }
    

}

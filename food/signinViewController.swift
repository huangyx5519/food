//
//  signinViewController.swift
//  food
//
//  Created by hyx on 2017/12/25.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class signinViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var msgLabel: UILabel!
    
    static var userId  = ""
    static var nickName  = ""
    
    @IBAction func loginButton(_ sender: Any) {
        if usernameText.text == "" {
            msgLabel.text = "用户名不能为空"
        }else if passwordText.text == ""{
            msgLabel.text = "密码不能为空"
        }else {
            let username = usernameText.text
            let password = passwordText.text
            
            Alamofire.request("http://119.29.189.146:8080/foodTracker/user/login?account="+username!+"&password="+password!, method: .get)
                .responseJSON { (response) in
                    if let json = response.result.value {
                        let JSOnDictory = JSON(json)
                        let status =  String(describing: JSOnDictory["status"])
                        
                        if status == "10002"
                        {
                            self.msgLabel.text = "用户名／密码错误"
                        }else{
                            let data = JSOnDictory["data"]["userInfo"]
                            let id = String(describing: data["id"])
                            let nickname = String(describing: data["nickname"])
                            signinViewController.userId = id
                            signinViewController.nickName = nickname
                            print("id\(id),,,,,nickname\(nickname)")
                            self.performSegue(withIdentifier: "login", sender: self)
                        }
                    }
            }
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}

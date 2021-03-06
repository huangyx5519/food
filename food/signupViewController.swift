//
//  signupViewController.swift
//  food
//
//  Created by hyx on 2017/12/25.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class signupViewController: UIViewController {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var repeatLabel: UITextField!
    @IBOutlet weak var nicknameLabel: UITextField!
    
    @IBAction func signupButton(_ sender: Any) {
        if usernameLabel.text == "" {
            msgLabel.text = "用户名不能为空"
            
        }else if passwordLabel.text == "" {
            msgLabel.text = "密码不能为空"
            
        }else if passwordLabel.text != repeatLabel.text{
            msgLabel.text = "密码不一致"
            
        }else if nicknameLabel.text == ""{
            msgLabel.text = "用户昵称不能为空"
        }else{
            let username = usernameLabel.text
            let password = passwordLabel.text
            let repeatla = repeatLabel.text
            let nickname = nicknameLabel.text
            
            
            Alamofire.request("http://119.29.189.146:8080/foodTracker/user/checkAccountUnique/?account="+username!, method: .get)
                .responseJSON { (response) in
                    if let json = response.result.value {
                        let JSOnDictory = JSON(json)
                        let data =  String(describing: JSOnDictory["data"]["isNotUsed"])
                        print("isNotUsed\(data)")
                        //let data =  String(describing: JSOnDictory["status")

                        if data == "false"{
                            self.msgLabel.text = "用户名重复"
                        }else{
                            let url1 = "http://119.29.189.146:8080/foodTracker/user/register?account="
                            let url2 = username!+"&password="+password!+"&nickname="+nickname!
                            let url = url1+url2
                            Alamofire.request(url, method: .get)
                                .responseJSON { (response) in
                                    if let json = response.result.value {
                                        let JSOnDictory = JSON(json)
                                        let data =  String(describing: JSOnDictory["status"])
                                        if data == "10001"{
                                            self.msgLabel.text = "注册成功"
                                            self.navigationController?.popViewController(animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        }
                            }
                        }
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

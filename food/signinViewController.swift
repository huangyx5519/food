//
//  signinViewController.swift
//  food
//
//  Created by hyx on 2017/12/25.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit

class signinViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var msgLabel: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        if usernameText.text == "" {
            msgLabel.text = "用户名不能为空"
        }else if passwordText.text == ""{
            msgLabel.text = "密码不能为空"
        }else {
            
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

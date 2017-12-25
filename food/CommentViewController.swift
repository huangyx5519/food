//
//  CommentViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var foodReview : FoodReview?
    var comments = [Comment]()
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var commentText: UITextField!
    @IBAction func postComment(_ sender: Any) {
        let userId = signinViewController.userId
        let foodId = foodReview?.id
        let content = commentText.text
        
        let url1 =  "http://119.29.189.146:8080/foodTracker/evaluation/newEvaluation?userId="
        let url2 = userId+"&foodRecordId="+foodId!+"&evaluationContent="+content!
        let url = url1+url2
        Alamofire.request(url, method: .get)
            .responseJSON { (response) in
                if let json = response.result.value {
                    let JSOnDictory = JSON(json)
                    let status = String(describing: JSOnDictory["status"])
                    if status == "10001"{
                        self.comments.append(Comment(content: content!,userName: signinViewController.nickName)!)
                        DispatchQueue.main.async(execute: {
                            self.commentTableView.reloadData()
                        })
                    }
                   
                }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate=self
        commentTableView.dataSource=self
        foodNameLabel.text = foodReview?.title
        foodDescLabel.text = foodReview?.desc
        loadSampleComments()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
//        print("comments")
//        print(comments.count)
        return comments.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CommentTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let comment = comments[indexPath.row]
        
        cell.commentText.text = comment.content
        cell.userNameText.text = comment.userName
        
        return cell
    }
    
    private func loadSampleComments() {
        
//        guard let comment1 = Comment( content: "食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍", userName: "haung") else {
//            fatalError("Unable to instantiate meal1")
//        }
//    
//        comments += [comment1,comment1,comment1]
        Alamofire.request("http://119.29.189.146:8080/foodTracker/foodRecord/getFoodRecordDetail?foodRecordId="+(foodReview?.id)!, method: .get)
            .responseJSON { (response) in
                if let json = response.result.value {
                    let JSOnDictory = JSON(json)
                    let count = JSOnDictory["data"]["foodRecordDetail"]["evaluationList"].count
                    if count > 0{
                    for index in 0...count-1 {
                        let foodCommentData =  JSOnDictory["data"]["foodRecordDetail"]["evaluationList"][index]
                        
                        let comment = String(describing: foodCommentData["evaluationContent"])
                       let nickname = String(describing: foodCommentData["userNickname"])
                        
                        self.comments.append(Comment(content: comment,userName: nickname)!)
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.commentTableView.reloadData()
                        
                        })
                        }

                    }
                }
        }
    }
}

//
//  CommentedTableViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CommentedTableViewController: UITableViewController {
    
    @IBOutlet var commentedTableView: UITableView!
    var commentedList = [commentFood]()
    
    func loadList(){
        let photo1 = UIImage(named: "屏幕快照 2017-12-12 下午10.27.09")
//        commentedList.append(commentFood(name: "breakfast" , desc: "delicious", comment: "good",photo : photo1))
//        commentedList.append(commentFood(name: "lunch" , desc: "yummy", comment:"nice",photo : photo1))
//        commentedList.append(commentFood(name: "dinner" , desc: "nice",comment:"so so", photo : photo1))
        
        Alamofire.request("http://119.29.189.146:8080/foodTracker/foodRecord/getMyEvaluatedFoodRecord?userId=1", method: .get)
            .responseJSON { (response) in
                if let json = response.result.value {
                    let JSOnDictory = JSON(json)
                    let count = JSOnDictory["data"]["evaluatedFoodRecord"].count
                    print("count\(count)")
                    for index in 0...count-1 {
                        let foodReviewsDatas =  JSOnDictory["data"]["evaluatedFoodRecord"][index]
                        let title = String(describing: foodReviewsDatas["foodName"])
                        let photo = String(describing: foodReviewsDatas["foodPicture"])
                        let rating = Int(String(describing: foodReviewsDatas["level"]))
                        let desc = String(describing: foodReviewsDatas["foodIntro"])
                        let userName = String(describing: foodReviewsDatas["userNickname"])
                        let comment = String(describing: foodReviewsDatas["evaluationContent"])
                        print("comment\(comment)")
                        self.commentedList.append(commentFood(name: title , desc: desc, comment: comment,photo : photo1))
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.commentedTableView.reloadData()
                            
                        })
                        
                        
                        //                        foodReviews.append(FoodReview(title: title,photo: photo1,rating: 4,desc: desc, userName: userName))
                        
                        
                    }
                    
                }
                
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentedList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CommentedTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let food = commentedList[indexPath.row]
        
        cell.nameLabel.text = food.name
        cell.descLabel.text = food.desc
        cell.commentLabel.text = food.comment
        cell.foodImage.image = food.photo
        
        return cell    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

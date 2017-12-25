//
//  FoodReviewTableViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//
import Alamofire
import UIKit
import SwiftyJSON

class FoodReviewTableViewController: UITableViewController {
    
    var foodReviews = [FoodReview]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleFoods()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return foodReviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FoodReviewTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodReviewTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let foodReview = foodReviews[indexPath.row]
        
        cell.title.text = foodReview.title
        cell.photoImageView.image = foodReview.photo
//        cell.ratingControl.rating = foodReview.rating
        cell.userName.text = foodReview.userName
        cell.desc.text=foodReview.desc
        
        return cell
    }
    

  
    //MARK: Private Methods
    
    private func loadSampleFoods() {
//        let photo1 = UIImage(named: "屏幕快照 2017-12-12 下午10.27.09")
//
//        guard let foodReview1 = FoodReview( title: "Pork", photo: photo1, rating: 4, desc:"食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍",userName: "huang") else {
//            fatalError("Unable to instantiate meal1")
//        }
//
//        foodReviews += [foodReview1,foodReview1,foodReview1]
        
//        let parameters: Parameters = ["lastFoodRecordId": "0"]
        
        Alamofire.request("http://119.29.189.146:8080/foodTracker/foodRecord/getOtherFoodRecord/?lastFoodRecordId=0", method: .get)
            .responseJSON { (response) in
                if let json = response.result.value {
                    let JSOnDictory = JSON(json)
//                    let count = JSOnDictory["data"]["foodRecordList"].count
//                    print("count\(count)")
                    let foodReviewsDatas =  JSOnDictory["data"]["foodRecordList"][0]
                    let title = foodReviewsDatas["foodName"]
                    let photo = foodReviewsDatas["foodPicture"]
                    let rating = foodReviewsDatas["foodName"]
                    let desc = foodReviewsDatas["foodName"]
                    print("title\(title)")
        
//                    a = foodReviewsDatas.
//                    for foodReviewdata in foodReviewsDatas{
//                        let title = foodReviewdata["foodName"]
//                        let photo = foodReviewdata["foodPicture"]
//                        let rating = foodReviewdata["foodName"]
//                        let desc = foodReviewdata["foodName"]
//                        let foodReview = FoodReview( title: title, photo: foodReviewdata["foodPicture"], rating: 4, desc:"食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍",userName: "huang")
//                        foodReviews+=foodReview
//                    }
                    
                    
//                    print("translation\(translation)")
                }
                
                
//                print(response)
//                let j = response.result.value
//                let JSOnDictory = JSON(j)
//                let translation =  JSOnDictory["data"]
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let showFoodReviewViewController = segue.destination as? ShowFoodReviewViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedFoodReviewCell = sender as? FoodReviewTableViewCell else {
                fatalError("Unexpected sender")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedFoodReviewCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedFoodReview = foodReviews[indexPath.row]
            showFoodReviewViewController.foodReview = selectedFoodReview
         
        case "Create":
            print("create")
            
        default:
            print("others")
//            fatalError("Unexpected Segue Identifier")
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreatFoodReviewViewController, let foodReview = sourceViewController.foodReview {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: foodReviews.count, section: 0)
            
            foodReviews.append(foodReview)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

}

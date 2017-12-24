//
//  FoodReviewTableViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit

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
    
    //MARK: Private Methods
    
    private func loadSampleFoods() {
        print("a")
        let photo1 = UIImage(named: "屏幕快照 2017-12-12 下午10.27.09")
        
        guard let foodReview1 = FoodReview( title: "Pork", photo: photo1, rating: 4, desc:"食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍",userName: "huang") else {
            fatalError("Unable to instantiate meal1")
        }
        
        foodReviews += [foodReview1,foodReview1,foodReview1]
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

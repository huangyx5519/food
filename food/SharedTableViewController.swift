//
//  SharedTableViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SharedTableViewController: UITableViewController {

    @IBOutlet var sharedTableView: UITableView!
    var sharedList = [FoodReview]()
    
    func loadList(){
        let photo1 = UIImage(named: "屏幕快照 2017-12-12 下午10.27.09")
        let id = signinViewController.userId
//        sharedList.append(sharedFood(name: "breakfast" , desc: "delicious", photo : photo1))
//        sharedList.append(sharedFood(name: "lunch" , desc: "yummy", photo : photo1))
//        sharedList.append(sharedFood(name: "dinner" , desc: "nice", photo : photo1))
        Alamofire.request("http://119.29.189.146:8080/foodTracker/foodRecord/getMyFoodRecord/?userId="+id, method: .get)
            .responseJSON { (response) in
                if let json = response.result.value {
                    let JSOnDictory = JSON(json)
                    let count = JSOnDictory["data"]["myFoodRecordList"].count
                    
                    if count > 0{
                    for index in 0...count-1 {
                        let foodReviewsDatas =  JSOnDictory["data"]["myFoodRecordList"][index]
                        let id = String(describing: foodReviewsDatas["foodRecordId"])
                        let title = String(describing: foodReviewsDatas["foodName"])
                        let photo = String(describing: foodReviewsDatas["foodPicture"])
                        let rating = Int(String(describing: foodReviewsDatas["level"]))
                        let desc = String(describing: foodReviewsDatas["foodIntro"])
                        let userName = String(describing: foodReviewsDatas["userNickname"])
                        print("title\(title)")
                        
                        var image = photo1
                        let url:URL = URL(string : photo)!
                        let data = try?Data(contentsOf: url)
                        if let imageData = data{
                            image = UIImage(data: imageData)
                        }
    
            
//                        self.sharedList.append(FoodReview(name: title,desc: desc,photo: photo1))
                        self.sharedList.append(FoodReview(id: id, title: title, photo: image, rating: 4,desc: desc, userName: userName)!)
                        
                        
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.sharedTableView.reloadData()
                            
                        })
                    }
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
        return sharedList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SharedTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SharedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let food = sharedList[indexPath.row]
        
        cell.nameLabel.text = food.title
        cell.descLabel.text = food.desc
        cell.foodImage.image = food.photo
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
//        case "ShowDetail":
//            guard let showFoodReviewViewController = segue.destination as? ShowFoodReviewViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//
//            guard let selectedFoodReviewCell = sender as? FoodReviewTableViewCell else {
//                fatalError("Unexpected sender")
//            }
//
//            guard let indexPath = tableView.indexPath(for: selectedFoodReviewCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//
//            let selectedFoodReview = sharedList[indexPath.row]
//            showFoodReviewViewController.foodReview = selectedFoodReview
            
        case "Modify":
            print("intoModify")
            guard let creatFoodReviewViewController = segue.destination as? CreatFoodReviewViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedFoodReviewCell = sender as? SharedTableViewCell else {
                fatalError("Unexpected sender")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedFoodReviewCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedFoodReview = sharedList[indexPath.row]
            creatFoodReviewViewController.foodReview = selectedFoodReview
            
            
        default:
            print("others")
            //            fatalError("Unexpected Segue Identifier")
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreatFoodReviewViewController, let foodReview = sourceViewController.foodReview {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                sharedList[selectedIndexPath.row] = foodReview
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
//            let newIndexPath = IndexPath(row: sharedList.count, section: 0)
//
//            sharedList.append(foodReview)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

}

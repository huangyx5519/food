//
//  CommentTableViewController.swift
//  food
//
//  Created by hyx on 2017/12/24.
//  Copyright © 2017年 hyx. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController {
    
    var foodReviews = [FoodReview]()
    var comments = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleComments()

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
        return comments.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        
        guard let comment1 = Comment( content: "食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍食物介绍", userName: "haung") else {
            fatalError("Unable to instantiate meal1")
        }
        
        comments += [comment1,comment1,comment1]
    }
}
